class Customers::RestaurantsController < ApplicationController
  def show
    @restaurant = Restaurant.find(params[:id])
    # byebug
    # for reorder using same resources
    if params.has_key?(:order_id)
      order = current_customer.orders.find(params[:order_id])
      if params[:func] == "view_order"
        @order = order

      elsif params[:func] == "re_order"
        @order = add_new_order(order: order)
      end

      calculate_sub_total
      @sub_total = @order.sub_total
      @total = @order.total

    else
      session.delete(:order_id)
      # if !session[:order_id].nil?
      #   @order = current_customer.orders.find(session[:order_id])
      # end
      @sub_total = 0
      @total = 0
    end
  end

  private
    def add_new_order(order:) # for reorder to process
      session.delete(:order_id)
      @order = current_order
      @order.save
      session[:order_id] = @order.id
      
      order.order_items.each do |oi|
        if oi.variation.present?
          variation = oi.menu_item.variations.find(oi.variation.id)
          @order_item = @order.order_items.new(name: oi.menu_item.name, price: oi.menu_item.price, quantity: oi.quantity, menu_item: oi.menu_item, variation: variation)
        else  
          @order_item = @order.order_items.new(name: oi.menu_item.name, price: oi.menu_item.price, quantity: oi.quantity, menu_item: oi.menu_item)
        end

        @order_item.save
        
        oi.order_add_ons.each do |ad_on|
          add_on = oi.menu_item.add_ons.find(ad_on.add_on_id)
          @order_item.order_add_ons.new(name: add_on.name, price: add_on.price, description: add_on.description, add_on: add_on).save!
        end
      end

      return @order
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
