class Owners::RestaurantsController < ApplicationController
	before_action :authenticate_owner!

	def index
		@categories = current_owner.restaurant.categories
	end

	# def new
	# 	# @owner = Owner.find(current_owner.id)
	# 	# @owners.build_restaurant
	# 	if current_owner.restaurant.nil?
	# 		@restaurant = Restaurant.new
	# 	else
	# 		redirect_to owners_dashboard_index_path
	# 	end
	# 	# current_owner.build_restaurant
	# end

	def edit
		# @owner = Owner.find(current_owner.id)
		# @restaurant = @owner.restaurant
		#@restaurant = current_owner.restaurant
		# byebug
		@restaurant = current_owner.restaurant
		# @restaurant = Restaurant.find(params[:id])
	end

	def update
		# @restaurant = Restaurant.find(params[:id])
		@restaurant = current_owner.restaurant
		if @restaurant.update(restaurant_params)
			redirect_to owners_restaurants_path
		else
			render 'edit'
		end
	end

	def get_names
		@names = Restaurant.all.select(:name)
		render json: @names, except: [:id]
	end

	def create
		# byebug
		# @owner = Owner.find(params[:owner_id])
		@restaurant = current_owner.build_restaurant(restaurant_params)
		# @restaurant.save
		if @restaurant.save
			redirect_to owners_restaurant_path(@restaurant)
		else
			render 'new'
		end
	end

	def destroy
		@restaurant = Restaurant.find(params[:id])
		if @restaurant.destroy
			redirect_to owners_dashboard_index_path
		end
	end
	def show
		# @restaurant = Restaurant.find_by(id: params[:id])
		@restaurant = current_owner.restaurant
		if @restaurant.nil?
			redirect_to owners_dashboard_index_path
		else
			render 'show'
		end
	end

	private
		def restaurant_params
			if params[:restaurant].present?
				params.require(:restaurant).permit(:name, :city, :address, :price, :tags, :delivery_time, :delivery_fee, categories_attributes: [:id, :_destroy, :name, menu_items_attributes: [:id, :_destroy, :name, :price, :note, variations_attributes: [:id, :_destroy, :name, :price, :description], add_ons_attributes: [:id, :_destroy, :name, :price, :description],images: []]])
			end
		end

end
