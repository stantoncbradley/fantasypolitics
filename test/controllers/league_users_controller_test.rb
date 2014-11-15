require 'test_helper'

class LeagueUsersControllerTest < ActionController::TestCase
  setup do
    @league_user = league_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:league_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create league_user" do
    assert_difference('LeagueUser.count') do
      post :create, league_user: {  }
    end

    assert_redirected_to league_user_path(assigns(:league_user))
  end

  test "should show league_user" do
    get :show, id: @league_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @league_user
    assert_response :success
  end

  test "should update league_user" do
    patch :update, id: @league_user, league_user: {  }
    assert_redirected_to league_user_path(assigns(:league_user))
  end

  test "should destroy league_user" do
    assert_difference('LeagueUser.count', -1) do
      delete :destroy, id: @league_user
    end

    assert_redirected_to league_users_path
  end
end
