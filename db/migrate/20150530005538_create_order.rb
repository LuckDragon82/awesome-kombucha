class CreateOrder < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :first_name
      t.string :last_name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :country
      t.string :zip_code
      t.string :status
      t.string :credit_card_number
      t.integer :credit_card_code
      t.string :credit_card_date
      t.integer :quantity
      t.decimal :total
    end
  end
end
