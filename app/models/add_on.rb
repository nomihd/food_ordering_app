class AddOn < ApplicationRecord
  belongs_to :menu_item
  has_many   :order_add_ons
end
