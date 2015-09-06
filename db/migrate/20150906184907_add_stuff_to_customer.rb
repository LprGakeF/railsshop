class AddStuffToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :street, :string
    add_column :customers, :house_number, :string
    add_column :customers, :postcode, :string
    add_column :customers, :country, :string
  end
end
