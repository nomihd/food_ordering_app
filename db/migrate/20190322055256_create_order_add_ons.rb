class CreateOrderAddOns < ActiveRecord::Migration[5.2]
  def change
    create_table :order_add_ons do |t|
      t.string :name
      t.integer :price
      t.string :description
      t.references :order_item, foreign_key: true

      t.timestamps
    end
  end
end
