require 'test_helper'
require 'byebug'
require "minitest/autorun"
class OrderTest < ActiveSupport::TestCase
  
  test 'should require correct validators' do
    order = Order.new
    assert_not order.valid?
    assert_equal [:first_name, :last_name, :address, :quantity, :credit_card_date], order.errors.keys
  end
  
  test 'should work if the required fields are provided' do
    order = Order.new(first_name: 'foo', last_name: 'bar', address: 'stuff', quantity: '3', credit_card_number: '1', credit_card_code: '1', credit_card_date: "01/#{(DateTime.now.strftime('%y').to_i + 10).to_s}")
    assert order.valid?
  end
  
  test 'should fail of the credit card date is incorrectly formatted' do
    order = Order.new(first_name: 'foo', last_name: 'bar', address: 'stuff', quantity: '3', credit_card_number: '1', credit_card_code: '1', credit_card_date: 'foo')
    assert_not order.valid?
  end

  test 'should fail if Credit Card process returns an error' do
    raises_exception = -> { raise ArgumentError.new }
    CreditCard.stub(:process, raises_exception) do
      order = Order.create(first_name: 'foo', last_name: 'bar', address: 'stuff', quantity: '3', credit_card_date: "01/#{(DateTime.now.strftime('%y').to_i + 10).to_s}")
      assert order.new_record?
    end
  end

  test 'should succeed if the Credit Card process is sucessful' do
    CreditCard.stub(:process, 'success') do
      order = Order.create(first_name: 'foo', last_name: 'bar', address: 'stuff', quantity: '3', credit_card_date: "01/#{(DateTime.now.strftime('%y').to_i + 10).to_s}")
      assert_not order.new_record?
    end
    Order.delete_all
  end
  
end