# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class RedirectUnstableTest < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "unstable")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/redirects.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Redirect.all(
      session: @test_session,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/redirects.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/redirects.json?since_id=668809255")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Redirect.all(
      session: @test_session,
      since_id: "668809255",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/redirects.json?since_id=668809255")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/unstable/redirects.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "redirect" => hash_including({path: "/ipod", target: "/pages/itunes"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    redirect = ShopifyAPI::Redirect.new(session: @test_session)
    redirect.path = "/ipod"
    redirect.target = "/pages/itunes"
    redirect.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/unstable/redirects.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/unstable/redirects.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "redirect" => hash_including({path: "http://www.apple.com/forums", target: "http://forums.apple.com"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    redirect = ShopifyAPI::Redirect.new(session: @test_session)
    redirect.path = "http://www.apple.com/forums"
    redirect.target = "http://forums.apple.com"
    redirect.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/unstable/redirects.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/redirects/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Redirect.count(
      session: @test_session,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/redirects/count.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/redirects/668809255.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Redirect.find(
      session: @test_session,
      id: 668809255,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/redirects/668809255.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/unstable/redirects/668809255.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "redirect" => hash_including({id: 668809255, path: "/tiger"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    redirect = ShopifyAPI::Redirect.new(session: @test_session)
    redirect.id = 668809255
    redirect.path = "/tiger"
    redirect.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/unstable/redirects/668809255.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/unstable/redirects/668809255.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "redirect" => hash_including({id: 668809255, target: "/pages/macpro"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    redirect = ShopifyAPI::Redirect.new(session: @test_session)
    redirect.id = 668809255
    redirect.target = "/pages/macpro"
    redirect.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/unstable/redirects/668809255.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/unstable/redirects/950115854.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "redirect" => hash_including({id: 950115854, path: "/powermac", target: "/pages/macpro"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    redirect = ShopifyAPI::Redirect.new(session: @test_session)
    redirect.id = 950115854
    redirect.path = "/powermac"
    redirect.target = "/pages/macpro"
    redirect.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/unstable/redirects/950115854.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/unstable/redirects/668809255.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Redirect.delete(
      session: @test_session,
      id: 668809255,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/unstable/redirects/668809255.json")
  end

end
