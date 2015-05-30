require 'test_helper'
class OrdersControllerTest < ActionController::TestCase
  test "should get show" do
    get :new
    assert_response :success
    assert_not_nil assigns(:order)
  end
end