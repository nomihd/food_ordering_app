class Customers::DashboardController < ApplicationController
	before_action :authenticate_customer!

  def index
  	@q = Restaurant.ransack(params[:q])
  	@restaurants = @q.result.includes(:categories, :menu_items)
    @categories = Category.pluck(:name).uniq
  end

  def show
  	@restaurant = Restaurant.find(params[:id])
  end
end
