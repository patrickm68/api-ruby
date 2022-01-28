# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class CancellationRequest202110Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-10")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/fulfillment_orders/1046000778/cancellation_request.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "cancellation_request" => hash_including({message: "The customer changed his mind."}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    cancellation_request = ShopifyAPI::CancellationRequest.new(session: @test_session)
    cancellation_request.fulfillment_order_id = 1046000778
    cancellation_request.message = "The customer changed his mind."
    cancellation_request.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/fulfillment_orders/1046000778/cancellation_request.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/fulfillment_orders/1046000779/cancellation_request/accept.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "cancellation_request" => hash_including({message: "We had not started any processing yet."}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    cancellation_request = ShopifyAPI::CancellationRequest.new(session: @test_session)
    cancellation_request.fulfillment_order_id = 1046000779
    cancellation_request.accept(
      body: {cancellation_request: {message: "We had not started any processing yet."}},
    )

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/fulfillment_orders/1046000779/cancellation_request/accept.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/fulfillment_orders/1046000780/cancellation_request/reject.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "cancellation_request" => hash_including({message: "We have already send the shipment out."}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    cancellation_request = ShopifyAPI::CancellationRequest.new(session: @test_session)
    cancellation_request.fulfillment_order_id = 1046000780
    cancellation_request.reject(
      body: {cancellation_request: {message: "We have already send the shipment out."}},
    )

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/fulfillment_orders/1046000780/cancellation_request/reject.json")
  end

end
