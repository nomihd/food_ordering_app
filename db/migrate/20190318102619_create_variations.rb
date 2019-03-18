class CreateVariations < ActiveRecord::Migration[5.2]
  def change
    create_table :variations do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.references :menu_item, foreign_key: true

      t.timestamps
    end
  end
end
