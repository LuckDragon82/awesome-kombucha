# Simulates processing a credit card with an external service
class CreditCard
  def self.process(order)
    
    (correct_attributes?(order)) ? SecureRandom.uuid : (raise 'invalid credit card transaction')
  end
  
  private
  
  def self.correct_attributes?(order)
    required = [:first_name, :last_name, :credit_card_number, :credit_card_code, :credit_card_date, :total]
    (order.compact.keys & required).sort == required.sort
  end
end