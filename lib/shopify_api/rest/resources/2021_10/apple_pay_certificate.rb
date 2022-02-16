# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class ApplePayCertificate < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :post, operation: :post, ids: [], path: "apple_pay_certificates.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "apple_pay_certificates/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "apple_pay_certificates/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "apple_pay_certificates/<id>.json"},
      {http_method: :get, operation: :csr, ids: [:id], path: "apple_pay_certificates/<id>/csr.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :merchant_id
    sig { returns(T.nilable(String)) }
    attr_reader :status

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String)
        ).returns(T.nilable(ApplePayCertificate))
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
        T.cast(result[0], T.nilable(ApplePayCertificate))
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
          id: T.any(Integer, String),
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def csr(
        session:,
        id:,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :csr,
          session: session,
          ids: {id: id},
          params: {}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

    end

  end
end
