class OrderItem < ApplicationRecord
  belongs_to :menu_item
  belongs_to :order
  has_many :order_variations
  has_many :order_add_ons
end
