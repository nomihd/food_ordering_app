class MenuItem < ApplicationRecord
  belongs_to :category
  has_many :variations, dependent: :destroy
  # has_many :order_items
  has_many :add_ons, dependent: :destroy
  has_many_attached :images
  accepts_nested_attributes_for :variations, allow_destroy: true
  accepts_nested_attributes_for :add_ons, allow_destroy: true
end
