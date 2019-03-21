class Owners::RestaurantsController < ApplicationController
	before_action :authenticate_owner!, only: [:index, :edit, :update]
	before_action :set_resturant

	def index
		@categories = @restaurant.categories
	end

	def edit
	end

	def update
		if @restaurant.update(restaurant_params)
			redirect_to owners_restaurants_path
		else
			render 'edit'
		end
	end

	
	def show
	end

	private
		def restaurant_params
			if params[:restaurant].present?
				params.require(:restaurant).permit(
					:name, :city, :address,
					:price, :tags, :delivery_time, :delivery_fee, 
					categories_attributes: 
						[:id, :_destroy, :name, 
							menu_items_attributes: 
							[:id, :_destroy, :name, :price, :note, images: [], 
								variations_attributes: 
								[:id, :_destroy, :name, :price, :description], 
							add_ons_attributes: [:id, :_destroy, :name, :price, :description]
						  ]
						])
			end
		end

		def set_resturant
			@restaurant = current_owner.restaurant
		end
end
