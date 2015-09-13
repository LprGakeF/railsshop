require 'test_helper'

include Devise::TestHelpers

class AdminItemsControllerTest < ActionController::TestCase

  setup do

    @controller = ItemsController.new

    @item = items(:one)
    @admin = customers(:admin)
    sign_in :customer, @admin
    #sign_in :customer, @admin
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item" do
    sign_in @admin
    assert_difference('Item.count') do
      post :create, item: { description: @item.description, name: @item.name }
    end

    assert_redirected_to item_path(assigns(:item))
  end

  test "should show item" do
    get :show, id: @item
    assert_response :success
  end

  test "should get edit" do
    sign_in :customer, @user
    get :edit, id: @item
    assert_response :success
  end

  test "should update item" do
    patch :update, id: @item, item: { description: @item.description, name: @item.name }
    assert_redirected_to item_path(assigns(:item))
  end

  test "should destroy item" do
    sign_in :customer, @user
    assert_difference('Item.count', -1) do
      delete :destroy, id: @item
    end

    assert_redirected_to items_path
  end
end
