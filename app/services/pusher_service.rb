Pusher.app_id = '122312'
Pusher.key = 'c26a1c6331c861eb0b91'
Pusher.secret = '65df568df1bb0a23f14c'

class PusherService
  def self.handle_order(order)
    push_order(order)
    push_sales
  end
  
  def self.push_shipped
    begin
      Pusher.trigger('sales_channel', 'shipped_update', {total: Order.where(status: 'shipped').sum('quantity')})
    rescue Pusher::Error => error
      logger.error "An error occrured while trying to push a new event #{error}"
    end    
  end
  
  private
  
  def self.push_order(order)
    begin
      Pusher.trigger('sales_channel', 'order', {first_name: order.first_name, last_name: order.last_name, quantity: order.quantity, city: order.city, country: order.country})
    rescue Pusher::Error => error
      logger.error "An error occrured while trying to push a new event #{error}"
    end
  end
  
  def self.push_sales
    begin
      Pusher.trigger('sales_channel', 'sale_update', {total: Order.sum('quantity')})
    rescue Pusher::Error => error
      logger.error "An error occrured while trying to push a new event #{error}"
    end
  end
  

end