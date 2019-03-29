class RemoveReferenceFromOrderVariations < ActiveRecord::Migration[5.2]
  def change
    remove_reference :order_variations, :order_item, foreign_key: true
  end
end
