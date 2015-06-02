require 'test_helper'
class HomeControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
    assert_not_nil assigns(:sold)
    assert_not_nil assigns(:shipped)    
  end

end