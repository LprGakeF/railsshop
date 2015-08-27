class AddCurrencyToItems < ActiveRecord::Migration
  def change
    add_column :items, :currency, :string, :default => 'EUR'
  end
end
