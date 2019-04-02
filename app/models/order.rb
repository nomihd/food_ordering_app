class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  # before_save :calculate
  def calculate
    sub_total = 0
    self.order_items.each do |o|
      price_plus_add_on = o.price + o.order_add_ons.pluck(:price).sum
      # byebug
      sub_total = sub_total + (o.quantity * price_plus_add_on)
    end
    # self[:sub_total] = sub_total
    return sub_total
  end
end
