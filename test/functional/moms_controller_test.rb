require 'test_helper'

class MomsControllerTest < ActionController::TestCase
  setup do
    @mom = moms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:moms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mom" do
    assert_difference('Mom.count') do
      post :create, mom: @mom.attributes
    end

    assert_redirected_to mom_path(assigns(:mom))
  end

  test "should show mom" do
    get :show, id: @mom.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mom.to_param
    assert_response :success
  end

  test "should update mom" do
    put :update, id: @mom.to_param, mom: @mom.attributes
    assert_redirected_to mom_path(assigns(:mom))
  end

  test "should destroy mom" do
    assert_difference('Mom.count', -1) do
      delete :destroy, id: @mom.to_param
    end

    assert_redirected_to moms_path
  end
end
