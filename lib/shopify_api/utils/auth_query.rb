# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Utils
    class AuthQuery
      extend T::Sig
      include VerifiableQuery

      sig { returns(String) }
      attr_reader :code, :host, :hmac, :shop, :state, :timestamp

      sig do
        params(
          code: String,
          shop: String,
          timestamp: String,
          state: String,
          host: String,
          hmac: String
        ).void
      end
      def initialize(code:, shop:, timestamp:, state:, host:, hmac:)
        @code = code
        @shop = shop
        @timestamp = timestamp
        @state = state
        @host = host
        @hmac = hmac
      end

      sig { override.returns(T::Hash[Symbol, String]) }
      def to_signable_hash
        {
          code: code,
          host: host,
          shop: shop,
          state: state,
          timestamp: timestamp,
        }
      end
    end
  end
end
