require 'test_helper'

class SchemesControllerTest < ActionController::TestCase
  setup do
    @scheme = schemes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:schemes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scheme" do
    assert_difference('Scheme.count') do
      post :create, scheme: { name: @scheme.name }
    end

    assert_redirected_to scheme_path(assigns(:scheme))
  end

  test "should show scheme" do
    get :show, id: @scheme
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scheme
    assert_response :success
  end

  test "should update scheme" do
    patch :update, id: @scheme, scheme: { name: @scheme.name }
    assert_redirected_to scheme_path(assigns(:scheme))
  end

  test "should destroy scheme" do
    assert_difference('Scheme.count', -1) do
      delete :destroy, id: @scheme
    end

    assert_redirected_to schemes_path
  end
end
