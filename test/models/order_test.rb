require 'test_helper'
require 'byebug'
require "minitest/autorun"
class OrderTest < ActiveSupport::TestCase
  
  def setup
    @valid_order = Order.new(first_name: 'foo', last_name: 'bar', street_address: 'stuff', city: 'foo', quantity: '3', credit_card_number: '1', credit_card_code: '1', credit_card_date: "01/#{(DateTime.now.strftime('%y').to_i + 10).to_s}", country: 'USA')
  end
  
  def teardown
    Order.delete_all
  end
  
  test 'should require correct validators' do
    order = Order.new
    assert_not order.valid?
    assert_equal [:first_name, :last_name, :street_address, :city, :quantity, :credit_card_date, :country].sort, order.errors.keys.sort
  end
  
  test 'should work if the required fields are provided' do
    order = @valid_order
    assert order.valid?
  end
  
  test 'should fail of the credit card date is incorrectly formatted' do
    @valid_order.credit_card_date = 'foo'
    order = @valid_order
    assert_not order.valid?
  end

  test 'should fail if Credit Card process returns an error' do
    raises_exception = -> { raise ArgumentError.new }
    CreditCard.stub(:process, raises_exception) do
      order = @valid_order
      assert order.new_record?
    end
  end

  test 'should succeed if the Credit Card process is sucessful' do
    CreditCard.stub(:process, 'success') do
      called = MiniTest::Mock.new
      PusherService.stub :handle_order, called do
        @valid_order.save
        assert_not @valid_order.new_record?
      end
    end
    Order.delete_all
  end
  
  test 'should call the pusher service handle_order after create' do
    called = MiniTest::Mock.new
    called2 = MiniTest::Mock.new
    called.expect(:call, nil, [@valid_order])
    PusherService.stub :handle_order, called do
      PusherService.stub :push_shipped, called2 do
        @valid_order.save
      end
    end
    called.verify
  end
  
  test 'should call the pusher service push_shipped after save if status is shipped' do
    called = MiniTest::Mock.new

    PusherService.stub :handle_order, called do
      @valid_order.save
      called2 = MiniTest::Mock.new
      @valid_order.status = 'shipped'
      called2.expect(:call, nil)
      PusherService.stub :push_shipped, called2 do
        @valid_order.save
      end
    end
    called.verify
  end

end