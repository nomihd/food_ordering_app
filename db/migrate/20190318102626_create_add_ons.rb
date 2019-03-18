class CreateAddOns < ActiveRecord::Migration[5.2]
  def change
    create_table :add_ons do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.references :menu_item, foreign_key: true

      t.timestamps
    end
  end
end
