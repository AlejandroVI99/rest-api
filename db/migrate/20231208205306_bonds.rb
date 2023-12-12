class Bonds < ActiveRecord::Migration[7.1]
  def change
    create_table :bonds do |t|
      t.string :name, null: false
      t.integer :quantity, null: false
      t.decimal :selling_price, null: false

      t.datetime :remember_created_at
      t.timestamps null: false
    end
  end
end
