module HomeHelper
	def user_type
		if current_owner.nil? && current_customer.nil?
			return 'no'
		elsif !current_owner.nil?
			return 'owner'
		elsif !current_customer.nil?
			return 'customer'	
		end
	end
end