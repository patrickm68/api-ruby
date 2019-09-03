require 'test_helper'

class CollectionTest < Test::Unit::TestCase
  test "Collection get products gets all products in a collection" do
    unstable_version = ShopifyAPI::Session.new(domain: 'shop2.myshopify.com', token: 'token2', api_version: :unstable)
    ShopifyAPI::Base.activate_session(unstable_version)

    fake(
        'collections',
        url: 'https://shop2.myshopify.com/admin/api/unstable/collections/1.json',
        method: :get,
        status: 200,
        body: load_fixture('collection'),
        extension: false
    )

    collection = ShopifyAPI::Collection.find(1)

    fake(
        'products',
        url: 'https://shop2.myshopify.com/admin/api/unstable/collections/1/products.json',
        method: :get,
        status: 200,
        body: load_fixture('collection_products'),
        extension: false
    )
    assert_equal [632910392, 921728736], collection.products.map(&:id)
  end
end
