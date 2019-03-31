class Variation < ApplicationRecord
  belongs_to :menu_item
  has_many   :order_items
end
