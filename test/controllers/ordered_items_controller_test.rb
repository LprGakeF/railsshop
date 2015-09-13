require 'test_helper'

class OrderedItemsControllerTest < ActionController::TestCase
  setup do
    @ordered_item = ordered_items(:one)
    #@admin = customers(:admin)   so jehts ^^
    #sign_in :customer, @admin
    @one = customers(:one)
    sign_in :customer, @one
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ordered_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ordered_item" do
    assert_difference('OrderedItem.count') do
      post :create, ordered_item: { customer_id: @ordered_item.customer_id, item_id: @ordered_item.item_id, quantity: @ordered_item.quantity }
    end

    assert_redirected_to ordered_item_path(assigns(:ordered_item))
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
    patch :update, id: @ordered_item, ordered_item: { customer_id: @ordered_item.customer_id, item_id: @ordered_item.item_id, quantity: @ordered_item.quantity }
    assert_redirected_to ordered_item_path(assigns(:ordered_item))
  end

  test "should destroy ordered_item" do
    assert_difference('OrderedItem.count', -1) do
      delete :destroy, id: @ordered_item
    end

    assert_redirected_to ordered_items_path
  end
end
