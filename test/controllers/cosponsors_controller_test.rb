require 'test_helper'

class CosponsorsControllerTest < ActionController::TestCase
  setup do
    @sponsor = cosponsors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sponsors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cosponsor" do
    assert_difference('Cosponsor.count') do
      post :create, sponsor: {  }
    end

    assert_redirected_to cosponsor_path(assigns(:sponsor))
  end

  test "should show cosponsor" do
    get :show, id: @sponsor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sponsor
    assert_response :success
  end

  test "should update cosponsor" do
    patch :update, id: @sponsor, sponsor: {  }
    assert_redirected_to cosponsor_path(assigns(:sponsor))
  end

  test "should destroy cosponsor" do
    assert_difference('Cosponsor.count', -1) do
      delete :destroy, id: @sponsor
    end

    assert_redirected_to cosponsors_path
  end
end
