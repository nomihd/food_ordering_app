class OrderAddOn < ApplicationRecord
  belongs_to :order_item
  belongs_to :add_on
end
