class Category < ApplicationRecord
  belongs_to :restaurant
  has_many :menu_items, dependent: :destroy
  accepts_nested_attributes_for :menu_items
	  
end
