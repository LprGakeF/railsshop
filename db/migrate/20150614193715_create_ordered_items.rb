class CreateOrderedItems < ActiveRecord::Migration
  def change
    create_table :ordered_items do |t|
      t.integer :quantity
      t.references :item, index: true
      t.references :customer, index: true

      t.boolean :is_in_process, :default => false
      t.boolean :is_dispatched, :default => false
      t.boolean :is_delivered, :default => false
      t.boolean :is_rejected, :default => false

      t.timestamps null: false
    end
    add_foreign_key :ordered_items, :items
    add_foreign_key :ordered_items, :customers
  end
end
