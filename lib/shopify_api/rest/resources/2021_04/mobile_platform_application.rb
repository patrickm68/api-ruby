# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class MobilePlatformApplication < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: nil)
      super(session: session)

      @application_id = T.let(nil, T.nilable(String))
      @enabled_shared_webcredentials = T.let(nil, T.nilable(T::Hash[T.untyped, T.untyped]))
      @enabled_universal_or_app_links = T.let(nil, T.nilable(T::Boolean))
      @id = T.let(nil, T.nilable(Integer))
      @platform = T.let(nil, T.nilable(String))
      @sha256_cert_fingerprints = T.let(nil, T.nilable(T::Array[T.untyped]))
    end

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "mobile_platform_applications.json"},
      {http_method: :post, operation: :post, ids: [], path: "mobile_platform_applications.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "mobile_platform_applications/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "mobile_platform_applications/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "mobile_platform_applications/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :application_id
    sig { returns(T.nilable(T::Hash[T.untyped, T.untyped])) }
    attr_reader :enabled_shared_webcredentials
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :enabled_universal_or_app_links
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :platform
    sig { returns(T.nilable(T::Array[String])) }
    attr_reader :sha256_cert_fingerprints

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String)
        ).returns(T.nilable(MobilePlatformApplication))
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
        T.cast(result[0], T.nilable(MobilePlatformApplication))
      end

      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String)
        ).returns(T.untyped)
      end
      def delete(
        session:,
        id:
      )
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          ids: {id: id},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T::Array[MobilePlatformApplication])
      end
      def all(
        session:,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[MobilePlatformApplication])
      end

    end

  end
end
