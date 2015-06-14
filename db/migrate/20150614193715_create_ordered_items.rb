class CreateOrderedItems < ActiveRecord::Migration
  def change
    create_table :ordered_items do |t|
      t.integer :quantity
      t.references :item, index: true
      t.references :customer, index: true

      t.timestamps null: false
    end
    add_foreign_key :ordered_items, :items
    add_foreign_key :ordered_items, :customers
  end
end
