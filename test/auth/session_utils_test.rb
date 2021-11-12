# typed: true
# frozen_string_literal: true

require_relative "../test_helper"

class SessionUtilsTest < Test::Unit::TestCase
  def setup
    super
    @jwt_payload = {
      iss: "https://test-shop.myshopify.io/admin",
      dest: "https://test-shop.myshopify.io",
      aud: ShopifyAPI::Context.api_key,
      sub: "1",
      exp: (Time.now + 10).to_i,
      nbf: 1234,
      iat: 1234,
      jti: "4321",
      sid: "abc123",
    }
    @jwt_token = JWT.encode(@jwt_payload, ShopifyAPI::Context.api_secret_key, "HS256")
    @jwt_header = "Bearer #{@jwt_token}"
    @shop = "test-shop.myshopify.io"

    @cookie_id = "1234-this-is-a-cookie-session-id"
    @cookies = { ShopifyAPI::Auth::Oauth::SessionCookie::SESSION_COOKIE_NAME => @cookie_id }
    @online_session = ShopifyAPI::Auth::Session.new(id: @cookie_id, shop: @shop, is_online: true)
    ShopifyAPI::Context.session_storage.store_session(@online_session)

    @online_embedded_session_id = "#{@shop}_#{@jwt_payload[:sub]}"
    @online_embedded_session = ShopifyAPI::Auth::Session.new(id: @online_embedded_session_id, shop: @shop,
      is_online: true)
    ShopifyAPI::Context.session_storage.store_session(@online_embedded_session)

    @offline_cookie_id = "offline_#{@shop}"
    @offline_cookies = { ShopifyAPI::Auth::Oauth::SessionCookie::SESSION_COOKIE_NAME => @offline_cookie_id }
    @offline_session = ShopifyAPI::Auth::Session.new(id: @offline_cookie_id, shop: @shop, is_online: false)
    ShopifyAPI::Context.session_storage.store_session(@offline_session)

    @offline_embedded_session = ShopifyAPI::Auth::Session.new(id: "offline_#{@shop}", shop: @shop, is_online: false)
    ShopifyAPI::Context.session_storage.store_session(@offline_embedded_session)
  end

  def test_gets_the_current_session_from_cookies_for_non_embedded_apps
    add_session(is_online: true)
    loaded_session = ShopifyAPI::Auth::SessionUtils.load_current_session(cookies: @cookies, online: true)
    assert_equal(@online_session, loaded_session)
  end

  def test_returns_nil_if_there_is_no_session_for_non_embedded_apps
    modify_context(session_storage: TestHelpers::FakeSessionStorage.new)
    assert_nil(ShopifyAPI::Auth::SessionUtils.load_current_session(
      auth_header: @jwt_header,
      cookies: @cookies,
      online: true
    ))
  end

  def test_gets_the_current_session_from_auth_header_for_embedded_apps
    modify_context(is_embedded: true)
    add_session(is_online: true)
    loaded_session = ShopifyAPI::Auth::SessionUtils.load_current_session(auth_header: @jwt_header, online: true)
    assert_equal(@online_embedded_session, loaded_session)
  end

  def test_loads_nothing_if_there_is_no_session_for_embedded_apps
    modify_context(is_embedded: true, session_storage: TestHelpers::FakeSessionStorage.new)
    loaded_session = ShopifyAPI::Auth::SessionUtils.load_current_session(auth_header: @jwt_header, online: true)
    assert_nil(loaded_session)
  end

  def test_fails_if_no_authorization_header_or_session_cookie_is_present
    modify_context(is_embedded: true)
    assert_raises(ShopifyAPI::Errors::CookieNotFoundError) do
      ShopifyAPI::Auth::SessionUtils.load_current_session(online: true)
    end
  end

  def test_fails_if_authorization_header_bearer_token_is_invalid
    modify_context(is_embedded: true)
    assert_raises(ShopifyAPI::Errors::InvalidJwtTokenError) do
      ShopifyAPI::Auth::SessionUtils.load_current_session(auth_header: "Bearer invalid", online: true)
    end
  end

  def test_fails_if_authorization_header_is_not_a_bearer_token
    modify_context(is_embedded: true)
    assert_raises(ShopifyAPI::Errors::MissingJwtTokenError) do
      ShopifyAPI::Auth::SessionUtils.load_current_session(auth_header: "Not a Bearer token", online: true)
    end
  end

  def test_falls_back_to_the_cookie_session_for_embedded_apps
    modify_context(is_embedded: true)
    loaded_session = ShopifyAPI::Auth::SessionUtils.load_current_session(cookies: @cookies, online: true)
    assert_equal(@online_session, loaded_session)
  end

  def test_loads_offline_sessions_from_cookies
    loaded_session = ShopifyAPI::Auth::SessionUtils.load_current_session(cookies: @offline_cookies, online: false)
    assert_equal(@offline_session, loaded_session)
  end

  def test_loads_offline_sessions_from_jwt_token
    modify_context(is_embedded: true)
    loaded_session = ShopifyAPI::Auth::SessionUtils.load_current_session(auth_header: @jwt_header, cookies: {},
      online: false)
    assert_equal(@offline_embedded_session, loaded_session)
  end

  def test_returns_nil_if_no_offline_session_exists
    modify_context(session_storage: TestHelpers::FakeSessionStorage.new)
    assert_nil(ShopifyAPI::Auth::SessionUtils.load_offline_session(shop: @shop))
  end

  def test_loads_offline_session_by_shop
    loaded_session = ShopifyAPI::Auth::SessionUtils.load_offline_session(shop: @shop)
    assert_equal(@offline_session, loaded_session)
  end

  def test_returns_nil_for_expired_offline_session
    offline_session = ShopifyAPI::Auth::Session.new(id: "offline_#{@shop}", shop: @shop, is_online: false,
      expires: Time.now - 60)
    ShopifyAPI::Context.session_storage.store_session(offline_session)
    loaded_session = ShopifyAPI::Auth::SessionUtils.load_offline_session(shop: @shop)
    assert_nil(loaded_session)
  end

  def test_loads_expired_offline_session_if_requested
    offline_session = ShopifyAPI::Auth::Session.new(id: "offline_#{@shop}", shop: @shop, is_online: false,
      expires: Time.now - 60)
    ShopifyAPI::Context.session_storage.store_session(offline_session)
    loaded_session = ShopifyAPI::Auth::SessionUtils.load_offline_session(shop: @shop, include_expired: true)
    assert_equal(offline_session, loaded_session)
  end

  def test_deletes_the_current_session_when_using_cookies
    add_session(is_online: true)
    assert(ShopifyAPI::Auth::SessionUtils.delete_current_session(cookies: @cookies, online: true))
    assert_nil(ShopifyAPI::Auth::SessionUtils.load_current_session(cookies: @cookies, online: true))
  end

  def test_deletes_the_current_session_when_using_jwt
    modify_context(is_embedded: true)
    add_session(is_online: true)
    assert(ShopifyAPI::Auth::SessionUtils.delete_current_session(auth_header: @jwt_header, online: true))
    assert_nil(ShopifyAPI::Auth::SessionUtils.load_current_session(auth_header: @jwt_header, online: true))
  end

  def test_deletes_the_current_offline_session_when_using_cookies
    add_session(is_online: false)
    assert(ShopifyAPI::Auth::SessionUtils.delete_current_session(cookies: @offline_cookies, online: false))
    assert_nil(ShopifyAPI::Auth::SessionUtils.load_current_session(cookies: @offline_cookies, online: false))
  end

  def test_deletes_the_current_offline_session_when_using_jwt
    modify_context(is_embedded: true)
    add_session(is_online: false)
    assert(ShopifyAPI::Auth::SessionUtils.delete_current_session(auth_header: @jwt_header, online: false))
    assert_nil(ShopifyAPI::Auth::SessionUtils.load_current_session(auth_header: @jwt_header, online: false))
  end

  def test_raises_an_error_when_no_session_is_found_to_delete
    assert_raises(ShopifyAPI::Errors::CookieNotFoundError) do
      ShopifyAPI::Auth::SessionUtils.delete_current_session(auth_header: @jwt_header, cookies: {}, online: true)
    end
    assert_raises(ShopifyAPI::Errors::CookieNotFoundError) do
      ShopifyAPI::Auth::SessionUtils.delete_current_session(auth_header: @jwt_header, cookies: {}, online: false)
    end
    assert_raises(ShopifyAPI::Errors::CookieNotFoundError) do
      ShopifyAPI::Auth::SessionUtils.delete_current_session(auth_header: @jwt_header, online: true)
    end
    assert_raises(ShopifyAPI::Errors::CookieNotFoundError) do
      ShopifyAPI::Auth::SessionUtils.delete_current_session(auth_header: @jwt_header, online: false)
    end
  end

  def test_raises_an_error_when_deleting_with_authorization_header
    modify_context(is_embedded: true)
    assert_raises(ShopifyAPI::Errors::InvalidJwtTokenError) do
      ShopifyAPI::Auth::SessionUtils.delete_current_session(auth_header: "Bearer invalid", online: true)
    end
  end

  def test_deletes_the_offline_session
    add_session(is_online: false)
    assert(ShopifyAPI::Auth::SessionUtils.delete_offline_session(shop: @shop))
    assert_nil(ShopifyAPI::Auth::SessionUtils.load_offline_session(shop: @shop))
  end

  private

  def add_session(is_online:)
    another_session = ShopifyAPI::Auth::Session.new(shop: @shop, is_online: is_online)
    ShopifyAPI::Context.session_storage.store_session(another_session)
  end
end
