require 'test_helper'

module MoodeUserPlugin
  class RegisterControllerTest < ActionController::TestCase
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should get create" do
      get :create
      assert_response :success
    end
  
  end
end
