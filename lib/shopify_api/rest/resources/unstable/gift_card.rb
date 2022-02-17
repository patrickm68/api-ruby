# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class GiftCard < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: nil)
      super(session: session)

      @api_client_id = T.let(nil, T.nilable(Integer))
      @balance = T.let(nil, T.nilable(Balance))
      @code = T.let(nil, T.nilable(String))
      @created_at = T.let(nil, T.nilable(String))
      @currency = T.let(nil, T.nilable(Currency))
      @customer_id = T.let(nil, T.nilable(Integer))
      @disabled_at = T.let(nil, T.nilable(String))
      @expires_on = T.let(nil, T.nilable(String))
      @id = T.let(nil, T.nilable(Integer))
      @initial_value = T.let(nil, T.nilable(Float))
      @last_characters = T.let(nil, T.nilable(String))
      @line_item_id = T.let(nil, T.nilable(Integer))
      @note = T.let(nil, T.nilable(String))
      @order_id = T.let(nil, T.nilable(Integer))
      @template_suffix = T.let(nil, T.nilable(String))
      @updated_at = T.let(nil, T.nilable(String))
      @user_id = T.let(nil, T.nilable(Integer))
    end

    @has_one = T.let({
      balance: Balance,
      currency: Currency
    }, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "gift_cards.json"},
      {http_method: :post, operation: :post, ids: [], path: "gift_cards.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "gift_cards/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "gift_cards/<id>.json"},
      {http_method: :get, operation: :count, ids: [], path: "gift_cards/count.json"},
      {http_method: :post, operation: :disable, ids: [:id], path: "gift_cards/<id>/disable.json"},
      {http_method: :get, operation: :search, ids: [], path: "gift_cards/search.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(Integer)) }
    attr_reader :api_client_id
    sig { returns(T.nilable(Balance)) }
    attr_reader :balance
    sig { returns(T.nilable(String)) }
    attr_reader :code
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Currency)) }
    attr_reader :currency
    sig { returns(T.nilable(Integer)) }
    attr_reader :customer_id
    sig { returns(T.nilable(String)) }
    attr_reader :disabled_at
    sig { returns(T.nilable(String)) }
    attr_reader :expires_on
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Float)) }
    attr_reader :initial_value
    sig { returns(T.nilable(String)) }
    attr_reader :last_characters
    sig { returns(T.nilable(Integer)) }
    attr_reader :line_item_id
    sig { returns(T.nilable(String)) }
    attr_reader :note
    sig { returns(T.nilable(Integer)) }
    attr_reader :order_id
    sig { returns(T.nilable(String)) }
    attr_reader :template_suffix
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :user_id

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String)
        ).returns(T.nilable(GiftCard))
      end
      def find(
        session:,
        id:
      )
        result = base_find(
          session: session,
          ids: {id: id},
          params: {},
        )
        T.cast(result[0], T.nilable(GiftCard))
      end

      sig do
        params(
          session: Auth::Session,
          status: T.untyped,
          limit: T.untyped,
          since_id: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[GiftCard])
      end
      def all(
        session:,
        status: nil,
        limit: nil,
        since_id: nil,
        fields: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {status: status, limit: limit, since_id: since_id, fields: fields}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[GiftCard])
      end

      sig do
        params(
          session: Auth::Session,
          status: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        status: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          ids: {},
          params: {status: status}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

      sig do
        params(
          session: Auth::Session,
          order: T.untyped,
          query: T.untyped,
          limit: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def search(
        session:,
        order: nil,
        query: nil,
        limit: nil,
        fields: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :search,
          session: session,
          ids: {},
          params: {order: order, query: query, limit: limit, fields: fields}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

    end

    sig do
      params(
        body: T.untyped,
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def disable(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :disable,
        session: @session,
        ids: {id: @id},
        params: {}.merge(kwargs).compact,
        body: body,
        entity: self,
      )
    end

  end
end
