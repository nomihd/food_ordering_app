class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :city
      t.text :address
      t.string :price
      t.string :tags
      t.string :delivery_time
      t.string :delivery_fee
      t.references :owner, foreign_key: true

      t.timestamps
    end
  end
end
