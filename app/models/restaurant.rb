class Restaurant < ApplicationRecord
	belongs_to :owner
	has_many :categories
	has_many :menu_items, through: :categories
	validates :name, uniqueness: true
	validates :address, :price, :tags, presence: true
	
end
