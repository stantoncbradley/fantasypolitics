require 'test_helper'

class LeagueUsersControllerTest < ActionController::TestCase
  setup do
    @teams = league_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:Teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create league_user" do
    assert_difference('LeagueUser.count') do
      post :create, Teams: {  }
    end

    assert_redirected_to league_user_path(assigns(:Teams))
  end

  test "should show league_user" do
    get :show, id: @teams
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @teams
    assert_response :success
  end

  test "should update league_user" do
    patch :update, id: @teams, Teams: {  }
    assert_redirected_to league_user_path(assigns(:Teams))
  end

  test "should destroy league_user" do
    assert_difference('LeagueUser.count', -1) do
      delete :destroy, id: @teams
    end

    assert_redirected_to league_users_path
  end
end
