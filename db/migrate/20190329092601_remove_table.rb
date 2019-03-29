class RemoveTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :order_variations
  end
end
