class SalesInfoController < ApplicationController 
  def index
    @sales = Order.order(id: :desc).limit(10)
  end
end