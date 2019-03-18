class MenuItem < ApplicationRecord
  belongs_to :category
  has_many :variations
  # has_many :order_items
  has_many :add_ons
end
