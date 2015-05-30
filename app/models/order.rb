class Order < ActiveRecord::Base
  validates :first_name, :last_name, :street_address, :country, :credit_card_number, :credit_card_code, :quantity, :credit_card_date, presence: true
end