class Customers::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :find_order, except: [:create, :index]

  def index
    @orders = current_customer.orders
  end

  def create
    if !params[:order].blank? # if it's reorder
      session.delete(:order_id)
    end

    @order = AddToCart.call(order: current_order, params: params, session: session)
      calculate_sub_total

  end
  def update
    order_item = @order.order_items.find(params[:order_item_id])
    if params[:func] == "add"
      order_item.update(quantity: order_item.quantity + 1)
      calculate_sub_total
    elsif params[:func] == "sub"
      if order_item.quantity > 1
        order_item.update(quantity: order_item.quantity - 1)
        calculate_sub_total
      else
        delete_order(order_item: order_item)
      end
    end

    

  end

  def delete_cart_row
    order_item = @order.order_items.find(params[:order_item_id])
    delete_order(order_item: order_item)

  
  end
  # delete all
  def destroy
    @order.destroy
    session.delete(:order_id)
    @sub_total = 0
    @total = 0

    respond_to do |format|
      format.html {redirect_to customers_orders_path}
      format.js
    end
  end

  def checkout
    if @order.update(status: "completed")

      flash[:success] = "Order has been placed"

      redirect_to customers_restaurant_path(@order.order_items.first.menu_item.category.restaurant)
    end
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
        calculate_sub_total
      else
        @order.destroy
        session.delete(:order_id)
        @sub_total = 0
        @total = 0
      end
    end

    def calculate_sub_total
      @order.sub_total = @order.calculate
      @sub_total = @order.sub_total
      delivery_fee = @order.order_items.first.menu_item.category.restaurant.delivery_fee
      @total = @sub_total + delivery_fee
      @order.delivery_fee = delivery_fee
      @order.total = @total
      @order.save
    end
end
