# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Location < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({
      country: Country,
      province: Province
    }, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "locations.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "locations/<id>.json"},
      {http_method: :get, operation: :count, ids: [], path: "locations/count.json"},
      {http_method: :get, operation: :inventory_levels, ids: [:id], path: "locations/<id>/inventory_levels.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :active
    sig { returns(T.nilable(String)) }
    attr_reader :address1
    sig { returns(T.nilable(String)) }
    attr_reader :address2
    sig { returns(T.nilable(String)) }
    attr_reader :city
    sig { returns(T.nilable(Country)) }
    attr_reader :country
    sig { returns(T.nilable(String)) }
    attr_reader :country_code
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :legacy
    sig { returns(T.nilable(String)) }
    attr_reader :localized_country_name
    sig { returns(T.nilable(String)) }
    attr_reader :localized_province_name
    sig { returns(T.nilable(String)) }
    attr_reader :name
    sig { returns(T.nilable(String)) }
    attr_reader :phone
    sig { returns(T.nilable(Province)) }
    attr_reader :province
    sig { returns(T.nilable(String)) }
    attr_reader :province_code
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(String)) }
    attr_reader :zip

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String)
        ).returns(T.nilable(Location))
      end
      def find(
        session:,
        id:
      )
        result = base_find(
          ids: {id: id},
          params: {},
          session: session,
        )
        T.cast(result[0], T.nilable(Location))
      end

      sig do
        params(
          session: Auth::Session
        ).returns(T.untyped)
      end
      def delete(session:)
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          path_ids: {},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T::Array[Location])
      end
      def all(
        session:,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[Location])
      end

      sig do
        params(
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          path_ids: {},
          params: {}.merge(kwargs).compact,
          entity: nil,
        )
      end

      sig do
        params(
          session: Auth::Session,
          id: T.nilable(T.any(Integer, String)),
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def inventory_levels(
        session:,
        id: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :inventory_levels,
          session: session,
          path_ids: {id: id},
          params: {}.merge(kwargs).compact,
          entity: nil,
        )
      end

    end

  end
end
