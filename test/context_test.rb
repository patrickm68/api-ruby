# typed: false
# frozen_string_literal: true

require_relative "./test_helper"

class ContextTest < Minitest::Test
  def test_setup_properly_initializes_variables
    ShopifyAPI::Context.setup(
      api_key: "key",
      api_secret_key: "secret",
      host_name: "host",
      session_storage: ShopifyAPI::Auth::FileSessionStorage.new
    )

    assert_equal(ShopifyAPI::Context.api_key, "key")
    assert_equal(ShopifyAPI::Context.api_secret_key, "secret")
    assert_equal(ShopifyAPI::Context.host_name, "host")
    assert_instance_of(ShopifyAPI::Auth::FileSessionStorage, ShopifyAPI::Context.session_storage)
  end
end
