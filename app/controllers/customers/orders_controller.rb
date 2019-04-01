class Customers::OrdersController < ApplicationController
  def create
    @order = AddToCart.call(order: current_order, params: params, session: session)
  end
  def update
    @order = Order.find(params[:id])
    # byebug
    order_item = @order.order_items.find(params[:order_item_id])
    if params[:func] == "add"
      order_item.update(quantity: order_item.quantity + 1)

    elsif params[:func] == "sub"
      if order_item.quantity > 1
        order_item.update(quantity: order_item.quantity - 1)
      else
        if @order.order_items.count > 1
          order_item.destroy
        else
          @order.destroy
          session.delete(:order_id)
    
        end
      end
    end

  end

  def delete_cart_row
    @order = Order.find(params[:id])
    order_item = @order.order_items.find(params[:order_item_id])

    if @order.order_items.count > 1
      order_item.destroy
    else
      @order.destroy
      session.delete(:order_id)
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    session.delete(:order_id)
  end

  private
    def order_params
      params.require(:order_item).permit(:sub_total, :delivery_fee, :total)
    end
end
