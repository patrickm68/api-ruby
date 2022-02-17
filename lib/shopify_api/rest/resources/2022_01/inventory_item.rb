# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class InventoryItem < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: nil)
      super(session: session)

      @cost = T.let(nil, T.nilable(String))
      @country_code_of_origin = T.let(nil, T.nilable(String))
      @country_harmonized_system_codes = T.let(nil, T.nilable(T::Array[T.untyped]))
      @created_at = T.let(nil, T.nilable(String))
      @harmonized_system_code = T.let(nil, T.nilable(Integer))
      @id = T.let(nil, T.nilable(Integer))
      @province_code_of_origin = T.let(nil, T.nilable(String))
      @requires_shipping = T.let(nil, T.nilable(T::Boolean))
      @sku = T.let(nil, T.nilable(String))
      @tracked = T.let(nil, T.nilable(T::Boolean))
      @updated_at = T.let(nil, T.nilable(String))
    end

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "inventory_items.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "inventory_items/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "inventory_items/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :cost
    sig { returns(T.nilable(String)) }
    attr_reader :country_code_of_origin
    sig { returns(T.nilable(T::Array[T::Hash[T.untyped, T.untyped]])) }
    attr_reader :country_harmonized_system_codes
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :harmonized_system_code
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :province_code_of_origin
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :requires_shipping
    sig { returns(T.nilable(String)) }
    attr_reader :sku
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :tracked
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String)
        ).returns(T.nilable(InventoryItem))
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
        T.cast(result[0], T.nilable(InventoryItem))
      end

      sig do
        params(
          session: Auth::Session,
          ids: T.untyped,
          limit: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[InventoryItem])
      end
      def all(
        session:,
        ids: nil,
        limit: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {ids: ids, limit: limit}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[InventoryItem])
      end

    end

  end
end
