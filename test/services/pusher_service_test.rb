require 'test_helper'
require "minitest/autorun"

class PusherServiceTest < ActiveSupport::TestCase
  
  test 'that handle_order should call pusher on channel sales_channel with event order and the order details' do
    order = Order.new(country: 'foo', first_name: 'bar', last_name: 'baz', quantity: 20)
    called = MiniTest::Mock.new
    called.expect(:call, nil, ['sales_channel', 'order', {first_name: order.first_name, last_name: order.last_name, quantity: order.quantity, city: order.city, country: order.country}])
    called.expect(:call, nil, [String, String, Hash])
    Pusher.stub :trigger, called do
      PusherService.handle_order(order)
    end
    called.verify
  end
  
  test 'that handle_order should call pusher on channel sales_channel with event sale_update and the sum of total sales' do
    order = Order.new(country: 'foo', first_name: 'bar', last_name: 'baz', quantity: 20)
    called = MiniTest::Mock.new
    called.expect(:call, nil, [String, String, Hash])
    called.expect(:call, nil, ['sales_channel', 'sale_update', {total: Order.sum('quantity')}])
    Pusher.stub :trigger, called do
      PusherService.handle_order(order)
    end
    called.verify
  end
  
  test 'that push_shipped should call pusher on channel sales_channel with event shipped_update with the quantity of all shipped orders' do
    called = MiniTest::Mock.new
    called.expect(:call, nil, ['sales_channel', 'shipped_update', {total: Order.where(status: 'shipped').sum('quantity')}])
    Pusher.stub :trigger, called do
      PusherService.push_shipped
    end
    called.verify
  end
end