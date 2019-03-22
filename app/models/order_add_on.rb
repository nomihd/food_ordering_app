class OrderAddOn < ApplicationRecord
  belongs_to :order_item
end
