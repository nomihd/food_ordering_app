class OrderItem < ApplicationRecord
  belongs_to :menu_item
  belongs_to :order
  belongs_to :variation, optional: true
  before_destroy :calculate
  before_save :calculate
  has_many :order_add_ons, dependent: :destroy
  has_many :add_ons, through: :order_add_ons

  def calculate
    sub_total = 0
    current_order.order_items.each do |o|
      price_plus_add_on = o.price + o.order_add_ons.pluck(:price).sum
      # byebug
      sub_total = sub_total + (o.quantity * price_plus_add_on)
    end
    current_order[:sub_total] = sub_total
    return sub_total
  end
end
