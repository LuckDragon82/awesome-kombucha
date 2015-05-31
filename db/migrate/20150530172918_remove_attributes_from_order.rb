class RemoveAttributesFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :street_address, :string
    remove_column :orders, :city, :string
    remove_column :orders, :state, :string
    remove_column :orders, :country, :string
    remove_column :orders, :zip_code, :string
    remove_column :orders, :credit_card_number, :string
    remove_column :orders, :credit_card_code, :integer
    remove_column :orders, :credit_card_date, :string
  end
end
