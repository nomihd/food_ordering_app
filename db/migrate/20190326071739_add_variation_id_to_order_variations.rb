class AddVariationIdToOrderVariations < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_variations, :variation, foreign_key: true
  end
end
