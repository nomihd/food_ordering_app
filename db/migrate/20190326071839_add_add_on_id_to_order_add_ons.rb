class AddAddOnIdToOrderAddOns < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_add_ons, :add_on, foreign_key: true
  end
end
