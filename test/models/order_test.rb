require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  
  test 'should require correct validators' do
    order = Order.new
    assert_not order.valid?
    assert_equal [:first_name, :last_name, :street_address, :country, :credit_card_number, :credit_card_code, :quantity, :credit_card_date], order.errors.keys
  end
  
  test 'should work if the required fields are provided' do
    order = Order.new(first_name: 'foo', last_name: 'bar', street_address: 'stuff', country: 'USA', credit_card_number: '234', credit_card_code: '3253', credit_card_date: '05/20', quantity: '3')
    assert order.valid?
  end
  
end