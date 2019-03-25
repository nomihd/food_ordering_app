class Customers::RestaurantsController < ApplicationController
  def show
    session.delete(:order_id)
    @restaurant = Restaurant.find(params[:id])
    @order = current_order
  end
end
