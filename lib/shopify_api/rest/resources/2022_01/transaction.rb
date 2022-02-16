# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Transaction < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [:order_id], path: "orders/<order_id>/transactions.json"},
      {http_method: :post, operation: :post, ids: [:order_id], path: "orders/<order_id>/transactions.json"},
      {http_method: :get, operation: :count, ids: [:order_id], path: "orders/<order_id>/transactions/count.json"},
      {http_method: :get, operation: :get, ids: [:order_id, :id], path: "orders/<order_id>/transactions/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(String) }
    attr_reader :kind
    sig { returns(T.nilable(String)) }
    attr_reader :amount
    sig { returns(T.nilable(String)) }
    attr_reader :authorization
    sig { returns(T.nilable(String)) }
    attr_reader :authorization_expires_at
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(String)) }
    attr_reader :currency
    sig { returns(T.nilable(Hash)) }
    attr_reader :currency_exchange_adjustment
    sig { returns(T.nilable(Integer)) }
    attr_reader :device_id
    sig { returns(T.nilable(String)) }
    attr_reader :error_code
    sig { returns(T.nilable(Hash)) }
    attr_reader :extended_authorization_attributes
    sig { returns(T.nilable(String)) }
    attr_reader :gateway
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Integer)) }
    attr_reader :location_id
    sig { returns(T.nilable(String)) }
    attr_reader :message
    sig { returns(T.nilable(Integer)) }
    attr_reader :order_id
    sig { returns(T.nilable(Integer)) }
    attr_reader :parent_id
    sig { returns(T.nilable(Hash)) }
    attr_reader :payment_details
    sig { returns(T.nilable(Hash)) }
    attr_reader :payments_refund_attributes
    sig { returns(T.nilable(String)) }
    attr_reader :processed_at
    sig { returns(T.nilable(Hash)) }
    attr_reader :receipt
    sig { returns(T.nilable(String)) }
    attr_reader :source_name
    sig { returns(T.nilable(String)) }
    attr_reader :status
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :test
    sig { returns(T.nilable(Integer)) }
    attr_reader :user_id

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          order_id: T.nilable(T.any(Integer, String)),
          fields: T.untyped,
          in_shop_currency: T.untyped
        ).returns(T.nilable(Transaction))
      end
      def find(
        session:,
        id:,
        order_id: nil,
        fields: nil,
        in_shop_currency: nil
      )
        result = base_find(
          session: session,
          ids: {id: id, order_id: order_id},
          params: {fields: fields, in_shop_currency: in_shop_currency},
        )
        T.cast(result[0], T.nilable(Transaction))
      end

      sig do
        params(
          session: Auth::Session,
          order_id: T.nilable(T.any(Integer, String)),
          since_id: T.untyped,
          fields: T.untyped,
          in_shop_currency: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Transaction])
      end
      def all(
        session:,
        order_id: nil,
        since_id: nil,
        fields: nil,
        in_shop_currency: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {order_id: order_id},
          params: {since_id: since_id, fields: fields, in_shop_currency: in_shop_currency}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[Transaction])
      end

      sig do
        params(
          session: Auth::Session,
          order_id: T.nilable(T.any(Integer, String)),
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        order_id: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          ids: {order_id: order_id},
          params: {}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

    end

  end
end
