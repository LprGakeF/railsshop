require 'test_helper'

include Devise::TestHelpers

class CustomerItemsControllerTest < ActionController::TestCase
  setup do

    @controller = ItemsController.new

    @item = items(:one)
    @user = customers(:one)
    sign_in :customer, @user
    #sign_in :customer, @admin
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should not get new" do
    get :new
    assert_response :redirect
  end

  test "should not create item" do
    assert_no_difference('Item.count') do
      post :create, item: { description: @item.description, name: @item.name }
    end
    assert_response :redirect
    #assert_redirected_to item_path(assigns(:item))
  end

  test "should show item" do
    get :show, id: @item
    assert_response :success
  end

  test "should not get edit" do
    get :edit, id: @item
    assert_response :redirect
  end

  test "should update item" do
    patch :update, id: @item, item: { description: @item.description, name: @item.name }
    assert_response :redirect
  end

  test "should not destroy item" do
    sign_in :customer, @user
    assert_difference('Item.count', 0) do
      delete :destroy, id: @item
    end

    assert_response :redirect
  end
end
