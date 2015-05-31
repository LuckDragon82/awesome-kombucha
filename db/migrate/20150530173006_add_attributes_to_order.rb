class AddAttributesToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :address, :string
    add_column :orders, :confirmation_number, :string
  end
end
