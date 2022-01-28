# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class CustomerAddressUnstableTest < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "unstable")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/customers/207119551/addresses.json?limit=1")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::CustomerAddress.all(
      session: @test_session,
      customer_id: "207119551",
      limit: "1",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/customers/207119551/addresses.json?limit=1")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/customers/207119551/addresses.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::CustomerAddress.all(
      session: @test_session,
      customer_id: "207119551",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/customers/207119551/addresses.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/customers/207119551/addresses/207119551.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::CustomerAddress.find(
      session: @test_session,
      customer_id: "207119551",
      id: "207119551",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/customers/207119551/addresses/207119551.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/customers/207119551/addresses/207119551.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "address" => hash_including({id: 207119551, zip: 90210}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    customer_address = ShopifyAPI::CustomerAddress.new(session: @test_session)
    customer_address.customer_id = 207119551
    customer_address.id = 207119551
    customer_address.zip = 90210
    customer_address.save()

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/customers/207119551/addresses/207119551.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/customers/207119551/addresses/1053317308.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::CustomerAddress.delete(
      session: @test_session,
      customer_id: "207119551",
      id: "1053317308",
    )

    assert_requested(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/customers/207119551/addresses/1053317308.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/customers/207119551/addresses.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "address" => hash_including({address1: "1 Rue des Carrieres", address2: "Suite 1234", city: "Montreal", company: "Fancy Co.", first_name: "Samuel", last_name: "de Champlain", phone: "819-555-5555", province: "Quebec", country: "Canada", zip: "G1R 4P5", name: "Samuel de Champlain", province_code: "QC", country_code: "CA", country_name: "Canada"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    customer_address = ShopifyAPI::CustomerAddress.new(session: @test_session)
    customer_address.customer_id = 207119551
    customer_address.address1 = "1 Rue des Carrieres"
    customer_address.address2 = "Suite 1234"
    customer_address.city = "Montreal"
    customer_address.company = "Fancy Co."
    customer_address.first_name = "Samuel"
    customer_address.last_name = "de Champlain"
    customer_address.phone = "819-555-5555"
    customer_address.province = "Quebec"
    customer_address.country = "Canada"
    customer_address.zip = "G1R 4P5"
    customer_address.name = "Samuel de Champlain"
    customer_address.province_code = "QC"
    customer_address.country_code = "CA"
    customer_address.country_name = "Canada"
    customer_address.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/customers/207119551/addresses.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/customers/207119551/addresses/set.json?address_ids%5B%5D=1053317309&operation=destroy")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    customer_address = ShopifyAPI::CustomerAddress.new(session: @test_session)
    customer_address.customer_id = 207119551
    customer_address.set(
      body: {},
      address_ids: [1053317309],
      operation: "destroy",
    )

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/customers/207119551/addresses/set.json?address_ids%5B%5D=1053317309&operation=destroy")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/customers/207119551/addresses/1053317310/default.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    customer_address = ShopifyAPI::CustomerAddress.new(session: @test_session)
    customer_address.customer_id = 207119551
    customer_address.id = 1053317310
    customer_address.default(
      body: {},
    )

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/customers/207119551/addresses/1053317310/default.json")
  end

end
