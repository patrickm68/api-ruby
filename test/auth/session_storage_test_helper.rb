# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module SessionStorageTestHelper
  def session
    associated_user = ShopifyAPI::Auth::AssociatedUser.new(
      id: 123,
      first_name: "first-name",
      last_name: "last-name",
      email: "user@test.com",
      email_verified: true,
      account_owner: true,
      locale: "en-us",
      collaborator: true
    )
    ShopifyAPI::Auth::Session.new(
      id: "id",
      shop: "test-shop",
      state: "test-state",
      access_token: "test-access-token",
      scope: ["test-scope"],
      expires: 12345,
      is_online: true,
      associated_user: associated_user
    )
  end

  def test_store_session
    assert(@storage.store_session(session))
  end

  def test_load_session
    @storage.store_session(session)
    loaded_session = @storage.load_session(session.id)
    assert_equal(session.id, loaded_session.id)
    assert_equal(session.shop, loaded_session.shop)
    assert_equal(session.state, loaded_session.state)
    assert_equal(session.access_token, loaded_session.access_token)
    assert_equal(session.scope, loaded_session.scope)
    assert_equal(session.expires, loaded_session.expires)
    assert_equal(session.is_online, loaded_session.is_online)
    assert_equal(session.associated_user.id, loaded_session.associated_user.id)
    assert_equal(session.associated_user.first_name, loaded_session.associated_user.first_name)
    assert_equal(session.associated_user.last_name, loaded_session.associated_user.last_name)
    assert_equal(session.associated_user.email_verified, loaded_session.associated_user.email_verified)
    assert_equal(session.associated_user.account_owner, loaded_session.associated_user.account_owner)
    assert_equal(session.associated_user.locale, loaded_session.associated_user.locale)
    assert_equal(session.associated_user.collaborator, loaded_session.associated_user.collaborator)
  end

  def test_delete_session
    @storage.store_session(session)
    assert(@storage.delete_session(session.id))
    assert_nil(@storage.load_session(session.id))
  end
end
