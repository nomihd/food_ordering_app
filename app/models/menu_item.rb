class MenuItem < ApplicationRecord
  belongs_to :category
  has_many :variations, dependent: :destroy
  # has_many :order_items
  has_many :add_ons, dependent: :destroy
  accepts_nested_attributes_for :variations
  accepts_nested_attributes_for :add_ons
end
