# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Webhooks
    class Registry
      @registry = T.let({}, T::Hash[String, Registration])

      class << self
        extend T::Sig
        sig { params(topic: String, delivery_method: Symbol, path: String, handler: T.nilable(Handler)).void }
        def add_registration(topic:, delivery_method:, path:, handler: nil)
          @registry[topic] = case delivery_method
          when :pub_sub
            Registrations::PubSub.new(topic: topic, path: path)
          when :event_bridge
            Registrations::EventBridge.new(topic: topic, path: path)
          when :http
            unless handler
              raise Errors::InvalidWebhookRegistrationError, "Cannot create an Http registration without a handler."
            end
            Registrations::Http.new(topic: topic, path: path, handler: handler)
          else
            raise Errors::InvalidWebhookRegistrationError,
              "Unsupported delivery method #{delivery_method}. Allowed values: {:http, :pub_sub, :event_bridge}."
          end
        end

        sig { void }
        def clear
          @registry.clear
        end

        sig do
          params(
            session: Auth::Session
          ).returns(T::Array[RegisterResult])
        end
        def register_all(session:)
          topics = @registry.keys
          result = T.let([], T::Array[RegisterResult])
          topics.each do |topic|
            registration = T.must(@registry[topic])
            register_response = register(
              registration: registration,
              session: session
            )
            result.push(register_response)
          end
          result
        end

        sig { params(request: Request).void }
        def process(request)
          raise Errors::InvalidWebhookError, "Invalid webhook HMAC." unless Utils::HmacValidator.validate(request)

          handler = @registry[request.topic]&.handler

          unless handler
            raise Errors::NoWebhookHandler, "No webhook handler found for topic: #{request.topic}."
          end

          handler.handle(topic: request.topic, shop: request.shop, body: request.parsed_body)
        end

        private

        sig do
          params(
            registration: Registration,
            session: Auth::Session
          ).returns(RegisterResult)
        end
        def register(registration:, session:)
          client = Clients::Graphql::Admin.new(session)
          register_check_result = webhook_registration_needed?(client, registration)

          registered = true
          register_body = nil

          if register_check_result[:must_register]
            register_body = send_register_request(
              client,
              registration,
              register_check_result[:webhook_id]
            )
            registered = registration_sucessful?(
              register_body,
              registration.mutation_name(register_check_result[:webhook_id])
            )
          end

          RegisterResult.new(topic: registration.topic, success: registered, body: register_body)
        end

        sig do
          params(
            client: Clients::Graphql::Admin,
            registration: Registration,
          ).returns(T::Hash[Symbol, T.untyped])
        end
        def webhook_registration_needed?(client, registration)
          check_response = client.query(query: registration.build_check_query)
          raise Errors::WebhookRegistrationError,
            "Failed to check if webhook was already registered" unless check_response.ok?
          parsed_check_result = registration.parse_check_result(T.cast(check_response.body, T::Hash[String, T.untyped]))
          must_register = parsed_check_result[:current_address] != registration.callback_address

          { webhook_id: parsed_check_result[:webhook_id], must_register: must_register }
        end

        sig do
          params(
            client: Clients::Graphql::Admin,
            registration: Registration,
            webhook_id: T.nilable(String)
          ).returns(T::Hash[String, T.untyped])
        end
        def send_register_request(client, registration, webhook_id)
          register_response = client.query(
            query: registration.build_register_query(
              topic: registration.topic,
              webhook_id: webhook_id
            )
          )
          raise Errors::WebhookRegistrationError, "Failed to register webhook with Shopify" unless register_response.ok?
          T.cast(register_response.body, T::Hash[String, T.untyped])
        end

        sig { params(body: T::Hash[String, T.untyped], mutation_name: String).returns(T::Boolean) }
        def registration_sucessful?(body, mutation_name)
          !body.dig("data", mutation_name, "webhookSubscription").nil?
        end
      end
    end
  end
end
