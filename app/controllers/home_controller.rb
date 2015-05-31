class HomeController < ApplicationController
  def show
    @sold = Order.sum('quantity')
    @shipped = Order.where(status: 'shipped').sum('quantity')
  end
end