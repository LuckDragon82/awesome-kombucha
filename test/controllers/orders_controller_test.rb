require 'test_helper'
class OrdersControllerTest < ActionController::TestCase
  test "should get show" do
    get :new
    assert_response :success
    assert_not_nil assigns(:order)
  end
  
  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:order)
  end
  
  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: {first_name: 'foo', last_name: 'bar', street_address: '123 baz st', city: 'ft', state: 'fl', country: 'USA', zip_code: '34523', credit_card_number: 'f234', credit_card_code: '321', credit_card_date: '11/20', quantity: 1}
    end
 
    assert_redirected_to order_path(assigns(:order))
  end
end