class Order < ActiveRecord::Base
  attr_accessor :credit_card_number, :credit_card_code, :credit_card_date
  
  validates :first_name, :last_name, :address, :quantity, :country, presence: true
  validate :correct_credit_card_date
  
  before_create :calculate_amount, :authorize_credit_card
  
  after_create :update_pusher
  
  def correct_credit_card_date
    self.credit_card_date = credit_card_date || ''
    error = false
    date = credit_card_date.split '/'
    error = true if date.length < 2 || date[0] > '12' || date[1] < DateTime.now.strftime('%y')
    errors.add(:credit_card_date, 'is not valid') if error
  end
  
  def calculate_amount
    self.total = quantity * 10
  end
  
  private 
  
  def calculate_amount
    self.total = quantity * 10
  end
  
  def authorize_credit_card
    begin
      self.confirmation_number = CreditCard.process({credit_card_number: credit_card_number, credit_card_date: credit_card_date, credit_card_code: credit_card_code, first_name: first_name, last_name: last_name, total: total})
    rescue => e
      errors.add('credit_card_information', 'is not valid')
      false
    end
  end
  
  def update_pusher
    PusherService.handle_order(self)
  end
end