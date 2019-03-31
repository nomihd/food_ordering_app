class Customers::OrdersController < ApplicationController
  def create
    @order = AddToCart.call(order: current_order, params: params, session: session)
  end
  private
    def order_params
      params.require(:order_item).permit(:sub_total, :delivery_fee, :total)
    end
end
