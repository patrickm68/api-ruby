# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class OrderRisk < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :post, operation: :post, ids: [:order_id], path: "orders/<order_id>/risks.json"},
      {http_method: :get, operation: :get, ids: [:order_id], path: "orders/<order_id>/risks.json"},
      {http_method: :get, operation: :get, ids: [:order_id, :id], path: "orders/<order_id>/risks/<id>.json"},
      {http_method: :put, operation: :put, ids: [:order_id, :id], path: "orders/<order_id>/risks/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:order_id, :id], path: "orders/<order_id>/risks/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :cause_cancel
    sig { returns(T.nilable(Integer)) }
    attr_reader :checkout_id
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :display
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :merchant_message
    sig { returns(T.nilable(String)) }
    attr_reader :message
    sig { returns(T.nilable(Integer)) }
    attr_reader :order_id
    sig { returns(T.nilable(String)) }
    attr_reader :recommendation
    sig { returns(T.nilable(Float)) }
    attr_reader :score
    sig { returns(T.nilable(String)) }
    attr_reader :source

    class << self
      sig do
        returns(String)
      end
      def json_body_name()
        "risk"
      end

      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          order_id: T.nilable(T.any(Integer, String))
        ).returns(T.nilable(OrderRisk))
      end
      def find(
        session:,
        id:,
        order_id: nil
      )
        result = base_find(
          ids: {order_id: order_id, id: id},
          params: {},
          session: session,
        )
        T.cast(result[0], T.nilable(OrderRisk))
      end

      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          order_id: T.nilable(T.any(Integer, String))
        ).returns(T.untyped)
      end
      def delete(
        session:,
        id:,
        order_id: nil
      )
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          path_ids: {order_id: order_id, id: id},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          order_id: T.nilable(T.any(Integer, String)),
          kwargs: T.untyped
        ).returns(T::Array[OrderRisk])
      end
      def all(
        session:,
        order_id: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {order_id: order_id},
          params: {}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[OrderRisk])
      end

    end

  end
end
