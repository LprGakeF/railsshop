class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :house_number
      t.string :postcode
      t.string :country
      t.references :customer, index: true

      t.timestamps null: false
    end
    add_foreign_key :addresses, :customers
  end
end
