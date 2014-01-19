require 'test_helper'
require 'uri'

class ImageTest < Test::Unit::TestCase
  def test_create_image
    fake "products/632910392/images", :method => :post, :body => load_fixture('image')
    image = ShopifyAPI::Image.new(:product_id => 632910392)
    image.position = 1
    image.attachment = "R0lGODlhbgCMAPf/APbr48VySrxTO7IgKt2qmKQdJeK8lsFjROG5p/nz7Zg3MNmnd7Q1MLNVS9GId71hSJMZIuzTu4UtKbeEeakhKMl8U8WYjfr18YQaIbAf=="
    image.save

    assert_equal 'http://cdn.shopify.com/s/files/1/0006/9093/3842/products/ipod-nano.png?v=1389388540', image.src
    assert_equal 850703190, image.id
  end

  def test_get_images
    fake "products/632910392/images", :method => :get, :body => load_fixture('images')
    image = ShopifyAPI::Image.find(:all, :params => {:product_id => 632910392})
    assert_equal 2, image.size
  end

  def test_get_image
    fake "products/632910392/images/850703190", :method => :get, :body => load_fixture('image')
    image = ShopifyAPI::Image.find(850703190, :params => {:product_id => 632910392})
    assert_equal 850703190, image.id
  end
end
