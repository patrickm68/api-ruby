require 'test_helper'

class ShopifyApiTest < Test::Unit::TestCase
  
  context "Session" do
    should "not be valid without a url" do
      session = ShopifyAPI::Session.new(nil, "any-token")
      assert_not session.valid?
    end
    
    should "not be valid without token" do
      session = ShopifyAPI::Session.new("testshop.myshopify.com")
      assert_not session.valid?
    end

    should "be valid with any token and any url" do
      session = ShopifyAPI::Session.new("testshop.myshopify.com", "any-token")
      assert session.valid?
    end
    
    should "not raise error without params" do
      assert_nothing_raised do
        session = ShopifyAPI::Session.new("testshop.myshopify.com", "any-token")
      end
    end
    
    should "raise error if params passed but signature omitted" do
      assert_raises(RuntimeError) do
        session = ShopifyAPI::Session.new("testshop.myshopify.com", "any-token", {'foo' => 'bar'})
      end
    end
  end
end