class AddPaidToOrderedItems < ActiveRecord::Migration
  def change
    add_column :ordered_items, :paid, :boolean, :default => false
  end
end
