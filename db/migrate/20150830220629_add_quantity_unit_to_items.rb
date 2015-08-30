class AddQuantityUnitToItems < ActiveRecord::Migration
  def change
    add_column :items, :quantity_unit, :string
  end
end
