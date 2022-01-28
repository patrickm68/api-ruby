# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class CheckoutUnstableTest < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "unstable")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "checkout" => hash_including({line_items: [{variant_id: 39072856, quantity: 5}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    checkout = ShopifyAPI::Checkout.new(session: @test_session)
    checkout.line_items = [
      {
        variant_id: 39072856,
        quantity: 5
      }
    ]
    checkout.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "checkout" => hash_including({email: "me@example.com"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    checkout = ShopifyAPI::Checkout.new(session: @test_session)
    checkout.email = "me@example.com"
    checkout.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts/b490a9220cd14d7344024f4874f640a6/complete.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    checkout = ShopifyAPI::Checkout.new(session: @test_session)
    checkout.token = "b490a9220cd14d7344024f4874f640a6"
    checkout.complete(
      body: {},
    )

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts/b490a9220cd14d7344024f4874f640a6/complete.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Checkout.find(
      session: @test_session,
      token: "exuw7apwoycchjuwtiqg8nytfhphr62a",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts/bd5a8aa1ecd019dd3520ff791ee3a24c.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Checkout.find(
      session: @test_session,
      token: "bd5a8aa1ecd019dd3520ff791ee3a24c",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts/bd5a8aa1ecd019dd3520ff791ee3a24c.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Checkout.find(
      session: @test_session,
      token: "7yjf4v2we7gamku6a6h7tvm8h3mmvs4x",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "checkout" => hash_including({token: "exuw7apwoycchjuwtiqg8nytfhphr62a", email: "john.smith@example.com", shipping_address: {first_name: "John", last_name: "Smith", address1: "126 York St.", city: "Los Angeles", province_code: "CA", country_code: "US", phone: "(123)456-7890", zip: 90002}}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    checkout = ShopifyAPI::Checkout.new(session: @test_session)
    checkout.token = "exuw7apwoycchjuwtiqg8nytfhphr62a"
    checkout.email = "john.smith@example.com"
    checkout.shipping_address = {
      first_name: "John",
      last_name: "Smith",
      address1: "126 York St.",
      city: "Los Angeles",
      province_code: "CA",
      country_code: "US",
      phone: "(123)456-7890",
      zip: 90002
    }
    checkout.save()

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "checkout" => hash_including({token: "exuw7apwoycchjuwtiqg8nytfhphr62a", shipping_line: {handle: "shopify-Free Shipping-0.00"}}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    checkout = ShopifyAPI::Checkout.new(session: @test_session)
    checkout.token = "exuw7apwoycchjuwtiqg8nytfhphr62a"
    checkout.shipping_line = {
      handle: "shopify-Free Shipping-0.00"
    }
    checkout.save()

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a/shipping_rates.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Checkout.shipping_rates(
      session: @test_session,
      token: "exuw7apwoycchjuwtiqg8nytfhphr62a",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a/shipping_rates.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a/shipping_rates.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Checkout.shipping_rates(
      session: @test_session,
      token: "exuw7apwoycchjuwtiqg8nytfhphr62a",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a/shipping_rates.json")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts/zs9ru89kuqcdagk8bz4r9hnxt22wwd42/shipping_rates.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Checkout.shipping_rates(
      session: @test_session,
      token: "zs9ru89kuqcdagk8bz4r9hnxt22wwd42",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/checkouts/zs9ru89kuqcdagk8bz4r9hnxt22wwd42/shipping_rates.json")
  end

end
