require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  setup do
    @customer = customers(:one)
    @admin = customers(:admin)
    sign_in :customer, @admin
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customers)
  end

  test "should get new" do
    get :new
    assert_response :redirect
  end

  test "should not create customer" do
    assert_no_difference('Customer.count') do
      post :create, customer: { date_of_birth: @customer.date_of_birth, email: @customer.email, forename: @customer.forename, surname: @customer.surname }
    end
    assert_response :redirect
    #assert_redirected_to customer_path(assigns(:customer))
  end

  test "should show customer" do
    get :show, id: @customer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer
    assert_response :success
  end

  test "should update customer" do
    patch :update, id: @customer, customer: { date_of_birth: @customer.date_of_birth, email: @customer.email, forename: @customer.forename, surname: @customer.surname }
    assert_response :success
  end

  test "should not destroy customer" do
    assert_no_difference('Customer.count') do
      delete :destroy, id: @customer
    end

    assert_redirected_to customers_path
  end
end
