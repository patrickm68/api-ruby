# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class RecurringApplicationCharge202201Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2022-01")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/recurring_application_charges.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({name: "Super Duper Plan", price: 10.0, return_url: "http://super-duper.shopifyapps.com"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(session: @test_session)
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/recurring_application_charges.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({name: "Super Duper Plan", price: 10.0, return_url: "http://super-duper.shopifyapps.com", capped_amount: 100, terms: "$1 for 1000 emails"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(session: @test_session)
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.capped_amount = 100
    recurring_application_charge.terms = "$1 for 1000 emails"
    recurring_application_charge.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/recurring_application_charges.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({name: "Super Duper Plan", price: 10.0, return_url: "http://super-duper.shopifyapps.com", test: true}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(session: @test_session)
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.test = true
    recurring_application_charge.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/recurring_application_charges.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "recurring_application_charge" => hash_including({name: "Super Duper Plan", price: 10.0, return_url: "http://super-duper.shopifyapps.com", trial_days: 5}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(session: @test_session)
    recurring_application_charge.name = "Super Duper Plan"
    recurring_application_charge.price = 10.0
    recurring_application_charge.return_url = "http://super-duper.shopifyapps.com"
    recurring_application_charge.trial_days = 5
    recurring_application_charge.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/recurring_application_charges.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::RecurringApplicationCharge.all(
      session: @test_session,
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/recurring_application_charges.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/recurring_application_charges.json?since_id=455696195")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::RecurringApplicationCharge.all(
      session: @test_session,
      since_id: "455696195",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/recurring_application_charges.json?since_id=455696195")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/recurring_application_charges/455696195.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::RecurringApplicationCharge.find(
      session: @test_session,
      id: "455696195",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/recurring_application_charges/455696195.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/recurring_application_charges/455696195.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::RecurringApplicationCharge.delete(
      session: @test_session,
      id: "455696195",
    )

    assert_requested(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/recurring_application_charges/455696195.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/recurring_application_charges/455696195/customize.json?recurring_application_charge%5Bcapped_amount%5D=200")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(session: @test_session)
    recurring_application_charge.id = 455696195
    recurring_application_charge.customize(
      body: {},
      recurring_application_charge: {"capped_amount" => 200},
    )

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/recurring_application_charges/455696195/customize.json?recurring_application_charge%5Bcapped_amount%5D=200")
  end

end
