module Customers::DashboardHelper
	def all_categories
		@categories = Category.all.map(&:name)
	end
end
