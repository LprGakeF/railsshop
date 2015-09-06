class AddStuffToOrderedItems < ActiveRecord::Migration
  def change
    add_column :ordered_items, :shipping_mail_sent, :boolean, :default => false
    add_column :ordered_items, :payment_mail_sent, :boolean, :default => false
  end
end
