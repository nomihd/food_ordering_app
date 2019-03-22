class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.string :name
      t.integer :quantity
      t.integer :price
      t.references :menu_item, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
