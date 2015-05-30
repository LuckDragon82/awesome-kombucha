class OrdersController < ApplicationController
  
  def new
    @order = Order.new
  end
  
  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to action: 'show', id: @order.id
    else
      flash[:alert] = @order.errors.messages
      render :new
    end
  end
  
  def show
    
  end
  
  private
  
  def order_params
    params.require(:order).permit(:first_name, :last_name, :street_address, :city, :state, :country, :zip_code, :credit_card_number, :credit_card_code, :quantity, :total, :credit_card_date)
  end
  
end