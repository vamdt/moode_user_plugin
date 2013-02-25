require 'test_helper'

module MoodeUserPlugin
  class VerifyCodesControllerTest < ActionController::TestCase
    setup do
      @verify_code = verify_codes(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:verify_codes)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create verify_code" do
      assert_difference('VerifyCode.count') do
        post :create, verify_code: { code: @verify_code.code }
      end
  
      assert_redirected_to verify_code_path(assigns(:verify_code))
    end
  
    test "should show verify_code" do
      get :show, id: @verify_code
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @verify_code
      assert_response :success
    end
  
    test "should update verify_code" do
      put :update, id: @verify_code, verify_code: { code: @verify_code.code }
      assert_redirected_to verify_code_path(assigns(:verify_code))
    end
  
    test "should destroy verify_code" do
      assert_difference('VerifyCode.count', -1) do
        delete :destroy, id: @verify_code
      end
  
      assert_redirected_to verify_codes_path
    end
  end
end
