class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.date :date_of_birth

      t.timestamps null: false
    end
  end
end
