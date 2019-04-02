class ChangeRestaurantDeliveryFeeToInteger < ActiveRecord::Migration[5.2]
  def up
    change_column :restaurants, :delivery_fee, 'integer USING CAST(delivery_fee AS integer)'
  end

  def down
    change_column :restaurants, :delivery_fee, :string
  end

end
