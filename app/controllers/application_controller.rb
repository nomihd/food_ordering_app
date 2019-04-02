class ApplicationController < ActionController::Base
  helper_method :current_order
  def current_order
    if !session[:order_id].nil?
      current_customer.orders.find(session[:order_id])
    else
      # @order = Order.new
      current_customer.orders.new(status: "in_process")
    end
  end
end
