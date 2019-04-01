class Customers::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :find_order, except: [:create, :index]
  
  def index
    @orders = current_customer.orders
    @restaurant = @orders.first.order_items.first.menu_item.category.restaurant
  end

  def create
    @order = AddToCart.call(order: current_order, params: params, session: session)
  end
  def update
    order_item = @order.order_items.find(params[:order_item_id])
    if params[:func] == "add"
      order_item.update(quantity: order_item.quantity + 1)

    elsif params[:func] == "sub"
      if order_item.quantity > 1
        order_item.update(quantity: order_item.quantity - 1)
      else
        delete_order(order_item: order_item)
      end
    end

  end

  def delete_cart_row
    order_item = @order.order_items.find(params[:order_item_id])
    delete_order(order_item: order_item)
  end

  def destroy
    @order.destroy
    session.delete(:order_id)
  end

  private
    def order_params
      params.require(:order_item).permit(:sub_total, :delivery_fee, :total)
    end

    def find_order
      @order = Order.find(params[:id])
    end

    def delete_order(order_item:)
      if @order.order_items.count > 1
        order_item.destroy
      else
        @order.destroy
        session.delete(:order_id)
      end
    end
end
