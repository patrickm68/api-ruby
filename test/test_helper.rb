# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"

Dir[File.dirname(__FILE__) + "/test_helpers/*.rb"].each { |file| require file }

module Test
  module Unit
    class TestCase < Minitest::Test
      extend T::Sig

      sig { void }
      def setup
        ShopifyAPI::Context.setup(
          api_key: "API_KEY",
          api_secret_key: "API_SECRET_KEY",
          host_name: "app-address.com",
          scope: ["scope1", "scope2"],
          is_private: false,
          is_embedded: false,
          session_storage: TestHelpers::FakeSessionStorage.new
        )
      end

      sig do
        params(
          api_key: T.nilable(String),
          api_secret_key: T.nilable(String),
          host_name: T.nilable(String),
          scope: T.nilable(T::Array[String]),
          is_private: T.nilable(T::Boolean),
          is_embedded: T.nilable(T::Boolean),
          session_storage: T.nilable(ShopifyAPI::Auth::SessionStorage)
        ).void
      end
      def modify_context(
        api_key: nil,
        api_secret_key: nil,
        host_name: nil,
        scope: nil,
        is_private: nil,
        is_embedded: nil,
        session_storage: nil
      )
        ShopifyAPI::Context.setup(
          api_key: api_key ? api_key : ShopifyAPI::Context.api_key,
          api_secret_key: api_secret_key ? api_secret_key : ShopifyAPI::Context.api_secret_key,
          host_name: host_name ? host_name : ShopifyAPI::Context.host_name,
          scope: scope ? scope : ShopifyAPI::Context.scope,
          is_private: !is_private.nil? ? is_private : ShopifyAPI::Context.is_private,
          is_embedded: !is_embedded.nil? ? is_embedded : ShopifyAPI::Context.is_embedded,
          session_storage: session_storage ? session_storage : ShopifyAPI::Context.session_storage
        )
      end
    end
  end
end
