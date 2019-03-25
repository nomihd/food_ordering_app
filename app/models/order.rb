class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items
  before_save :calculate

  def calculate
    sub_total = 0
    self.order_items.each do |o|
      sub_total = sub_total + (o.quantity * o.price)
    end
    self[:sub_total] = sub_total
    return sub_total
  end
end
