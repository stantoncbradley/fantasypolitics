require 'test_helper'

class PoliticianBillsControllerTest < ActionController::TestCase
  setup do
    @politician_bill = politician_bills(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:politician_bills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create politician_bill" do
    assert_difference('PoliticianBill.count') do
      post :create, politician_bill: {  }
    end

    assert_redirected_to politician_bill_path(assigns(:politician_bill))
  end

  test "should show politician_bill" do
    get :show, id: @politician_bill
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @politician_bill
    assert_response :success
  end

  test "should update politician_bill" do
    patch :update, id: @politician_bill, politician_bill: {  }
    assert_redirected_to politician_bill_path(assigns(:politician_bill))
  end

  test "should destroy politician_bill" do
    assert_difference('PoliticianBill.count', -1) do
      delete :destroy, id: @politician_bill
    end

    assert_redirected_to politician_bills_path
  end
end
