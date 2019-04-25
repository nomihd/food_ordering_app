class ApplicationController < ActionController::Base
  helper_method :current_order
  def current_order
    if !session[:order_id].nil?
      current_customer.orders.find(session[:order_id])
    else
      current_customer.orders.new(status: "in_process")
    end
  end

  protected
  # override default inviter that was Owner itself
    def authenticate_inviter!
        authenticate_admin_user!(force: true)
    end
end
