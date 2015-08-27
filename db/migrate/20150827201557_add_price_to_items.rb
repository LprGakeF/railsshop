class AddPriceToItems < ActiveRecord::Migration
  def change
    add_column :items, :price, :decimal, :precision => 12, :scale => 2
  end
end
