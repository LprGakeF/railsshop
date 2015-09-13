require 'test_helper'

class OrderedItemsControllerTest < ActionController::TestCase
  setup do
    @controller = ItemsController.new

    @ordered_item = ordered_items(:one)
    @admin = customers(:admin)
    sign_in :customer, @admin
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ordered_items)
  end

  test "should not get new" do
    get :new
    assert_response :redirect
  end

  test "should not create ordered_item" do
    assert_no_difference('OrderedItem.count') do
        post :create, ordered_item: { customer_id: @ordered_item.customer_id, item_id: @ordered_item.item_id, quantity: @ordered_item.quantity,
        is_in_process: @ordered_item.is_in_process,
        is_dispatched: @ordered_item.is_dispatched, is_delivered: @ordered_item.is_delivered,
        is_rejected: @ordered_item.is_rejected, paid: @ordered_item.paid}

    end
    assert_response :redirect
  end

  test "should show ordered_item" do
    get :show, id: @ordered_item
    assert_response :success
  end

  test "should get edit" do
    sign_in @customer
    get :edit, id: @ordered_item
    assert_response :success
  end

  test "should update ordered_item" do
    patch :update, id: @ordered_item, ordered_item: { customer_id: @ordered_item.customer_id,
      item_id: @ordered_item.item_id, quantity: @ordered_item.quantity, is_in_process: @ordered_item.is_in_process,
      is_dispatched: @ordered_item.is_dispatched, is_delivered: @ordered_item.is_delivered,
      is_rejected: @ordered_item.is_rejected, paid: @ordered_item.paid}

    assert_redirected_to ordered_item_path(assigns(:ordered_item))
  end

  test "should not destroy ordered_item" do
    assert_no_difference('OrderedItem.count') do
      delete :destroy, id: @ordered_item
    end
    assert_redirected_to ordered_items_path
  end
end
