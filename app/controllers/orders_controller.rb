class OrdersController < ApplicationController
  
  def new
    @order = Order.new
  end
  
  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to action: 'show', id: @order.id
    else
      flash[:alert] = @order.errors.full_messages.join '. '
      render :new
    end
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  private
  
  def order_params
    params.require(:order).permit(:first_name, :last_name, :address, :quantity, :total, :country, :credit_card_number, :credit_card_code, :credit_card_date)
  end
  
end