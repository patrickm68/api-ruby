require 'test_helper'

class DraftOrderTest < Test::Unit::TestCase
  def setup
    super

    fake 'draft_orders/517119332', body: load_fixture('draft_order')

    @draft_order = ShopifyAPI::DraftOrder.find(517119332)
  end

  def test_get_draft_order
    fake 'draft_orders/517119332', method: :get, status: 200, body: load_fixture('draft_order')

    draft_order = ShopifyAPI::DraftOrder.find(517119332)

    assert_equal 517119332, draft_order.id
  end

  def test_get_all_draft_orders
    fake 'draft_orders', method: :get, status: 200, body: load_fixture('draft_orders')

    draft_orders = ShopifyAPI::DraftOrder.all

    assert_equal 1, draft_orders.length
    assert_equal 517119332, draft_orders.first.id
  end

  def test_create_draft_order
    fake 'draft_orders', method: :post, status: 201, body: load_fixture('draft_order')

    draft_order = ShopifyAPI::DraftOrder.create(line_items: [{ quantity: 1, variant_id: 39072856 }])

    assert_equal '{"draft_order":{"line_items":[{"quantity":1,"variant_id":39072856}]}}', FakeWeb.last_request.body
    assert_equal 39072856, draft_order.line_items.first.variant_id
  end

  def test_update_draft_order
    draft_order_response = ActiveSupport::JSON.decode(load_fixture('draft_order'))
    draft_order_response['draft_order']['note'] = 'Test new note'
    @draft_order.note = 'Test new note'
    fake 'draft_orders/517119332', method: :put, status: 200, body: ActiveSupport::JSON.encode(draft_order_response)

    @draft_order.save

    assert_equal draft_order_response['draft_order']['note'], @draft_order.note
  end

  def test_send_invoice_with_no_params
    fake 'draft_orders/517119332/send_invoice', method: :post, body: load_fixture('draft_order_invoice_no_params')

    @draft_order.send_invoice

    assert_equal '{"draft_order_invoice":{}}', FakeWeb.last_request.body
  end

  def test_send_invoice_with_params
    draft_order_invoice_fixture = load_fixture('draft_order_invoice')
    draft_order_invoice = ActiveSupport::JSON.decode(draft_order_invoice_fixture)
    fake 'draft_orders/517119332/send_invoice', method: :post, body: draft_order_invoice_fixture

    @draft_order.send_invoice(ShopifyAPI::DraftOrderInvoice.new(draft_order_invoice['draft_order_invoice']))

    assert_equal draft_order_invoice, ActiveSupport::JSON.decode(FakeWeb.last_request.body)
  end

  def test_delete_draft_order
    fake 'draft_orders/517119332', method: :delete, body: 'destroyed'
    assert @draft_order.destroy
  end

  def test_add_metafields_to_draft_order
    fake 'draft_orders/517119332/metafields', method: :post, status: 201, body: load_fixture('metafield')

    field = @draft_order.add_metafield(ShopifyAPI::Metafield.new(namespace: 'contact', key: 'email', value: '123@example.com', value_type: 'string'))

    assert_equal ActiveSupport::JSON.decode('{"metafield":{"namespace":"contact","key":"email","value":"123@example.com","value_type":"string"}}'), ActiveSupport::JSON.decode(FakeWeb.last_request.body)
    assert !field.new_record?
    assert_equal 'contact', field.namespace
    assert_equal 'email', field.key
    assert_equal '123@example.com', field.value
  end

  def test_get_metafields_for_draft_order
    fake 'draft_orders/517119332/metafields', body: load_fixture('metafields')

    metafields = @draft_order.metafields

    assert_equal 2, metafields.length
    assert metafields.all? { |m| m.is_a?(ShopifyAPI::Metafield) }
  end
end
