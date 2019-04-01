class OrderItem < ApplicationRecord
  belongs_to :menu_item
  belongs_to :order
  belongs_to :variation, optional: true
  has_many :order_add_ons, dependent: :destroy
  has_many :add_ons, through: :order_add_ons
end
