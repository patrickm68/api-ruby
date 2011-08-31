require 'test_helper'
require 'mocha'

class LimitsTest < Test::Unit::TestCase
  def setup
    ShopifyAPI::Base.site = "test.myshopify.com"
    @header_hash = {'http_x_shopify_api_call_limit' => '150/3000',
                    'http_x_shopify_shop_api_call_limit' => '100/300'}
    ShopifyAPI::Base.connection.expects(:response).at_least(0).returns(@header_hash)
  end
  
  context "Limits" do
    should "fetch limit total" do
      assert_equal(299, ShopifyAPI.credit_limit(:shop))
      assert_equal(2999, ShopifyAPI.credit_limit(:global))
    end
    
    should "fetch used calls" do
      assert_equal(100, ShopifyAPI.credit_used(:shop))
      assert_equal(150, ShopifyAPI.credit_used(:global))
    end
    
    should "calculate remaining calls" do
      assert_equal(199, ShopifyAPI.credit_left)
    end
    
    should "flag maxed out credits" do
      assert !ShopifyAPI.maxed?
      @header_hash = {'http_x_shopify_api_call_limit' => '2999/3000',
                      'http_x_shopify_shop_api_call_limit' => '299/300'}
      ShopifyAPI::Base.connection.expects(:response).at_least(1).returns(@header_hash)
      assert ShopifyAPI.maxed?
    end
  end
  
  
end