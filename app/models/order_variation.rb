class OrderVariation < ApplicationRecord
  belongs_to :order_item
  belongs_to :variation
end
