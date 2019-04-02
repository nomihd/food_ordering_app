class Customers::RestaurantsController < ApplicationController
  def show
    @restaurant = Restaurant.find(params[:id])
    # byebug
    # for reorder using same resources
    if params.has_key?(:order_id)
      @order = current_customer.orders.find(params[:order_id])
      @sub_total = @order.sub_total
      @total = @order.total
    else
      session.delete(:order_id)
      @sub_total = 0
      @total = 0
    end
  end
end
