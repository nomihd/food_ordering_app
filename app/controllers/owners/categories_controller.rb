class Owners::CategoriesController < ApplicationController
	before_action :authenticate_owner!

	def index
		@categories = current_owner.restaurant.categories#Category.all#.distinct
	end

	def new
		@category = Category.new
		# @category.menu_items.build
	end

	def create
		# @restaurant = Restaurant.find_by(owner_id: current_owner.id)
		current_owner.restaurant.categories.create(category_params)
		# @category = current_owner.restaurant.categories.Category.new(category_params)
		# if @category.save
		redirect_to owners_categories_path
		# else
		# 	render 'new'
		# end
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		if @category.update(category_params)
			redirect_to owners_categories_path
		else
			render 'edit'
		end
	end

	def destroy
		@menu_item = MenuItem.find(params[:id])
		# @category = @menu_item.category

		if @menu_item.destroy
			# if @category.menu_items.count == 0
			# 	@category.destroy
			# end
			redirect_to owners_categories_path
		else
			render 'index'
		end
	end

	private
		def category_params
			params.require(:category).permit(:name, menu_items_attributes: [:id, :_destroy, :name, :price, :note, variations_attributes: [:id, :_destroy, :name, :price, :description], add_ons_attributes: [:id, :_destroy, :name, :price, :description]])
		end

end

