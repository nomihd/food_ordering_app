class Customers::RestaurantsController < ApplicationController
  def show
    @restaurant = Restaurant.find(params[:id])
    # byebug
    if params.has_key?(:order_id)
      @order = current_customer.orders.find(params[:order_id])
    else
      session.delete(:order_id)
    end
  end
end
