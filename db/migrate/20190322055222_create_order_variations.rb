class CreateOrderVariations < ActiveRecord::Migration[5.2]
  def change
    create_table :order_variations do |t|
      t.string :name
      t.integer :price
      t.string :description
      t.references :order_item, foreign_key: true

      t.timestamps
    end
  end
end
