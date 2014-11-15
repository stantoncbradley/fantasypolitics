require 'test_helper'

class CosponsorsControllerTest < ActionController::TestCase
  setup do
    @cosponsor = cosponsors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cosponsors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cosponsor" do
    assert_difference('Cosponsor.count') do
      post :create, cosponsor: {  }
    end

    assert_redirected_to cosponsor_path(assigns(:cosponsor))
  end

  test "should show cosponsor" do
    get :show, id: @cosponsor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cosponsor
    assert_response :success
  end

  test "should update cosponsor" do
    patch :update, id: @cosponsor, cosponsor: {  }
    assert_redirected_to cosponsor_path(assigns(:cosponsor))
  end

  test "should destroy cosponsor" do
    assert_difference('Cosponsor.count', -1) do
      delete :destroy, id: @cosponsor
    end

    assert_redirected_to cosponsors_path
  end
end
