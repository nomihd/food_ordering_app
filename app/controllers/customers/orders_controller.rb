class Customers::OrdersController < ApplicationController
  def create
    @order = current_order
    @menu_item = MenuItem.find(params[:item_id])
    
    if @order.order_items.where(menu_item_id: params[:item_id]).any? # if same item has already been added for same order

      quantity = @order.order_items.where(menu_item_id: params[:item_id]).pluck(:quantity).first # fetch current quantity
      @order_item = @order.order_items.find_by(menu_item_id: params[:item_id]) # fetch corresponding order_item

      @order_item.update(quantity: quantity+1) # update quantity
      # puts "iffff"
      # puts @order_item.class

      is_same = false

      if params.has_key?(:variation_id)
        @variation = @menu_item.variations.find(params[:variation_id])
        @order_item.price = @variation.price # variation price took over primary price
        if @order_item.order_variations.where(order_item_id: params[:item_id]).any?
          @order_item.price = @variation.price
          is_same = true
        #else

          #@order_variation = @order_item.order_variations.new(name: @variation.name, price: @variation.price, description: @variation.description)
        end
      end

      if params.has_key?(:add_id)  
        @add_on = @menu_item.add_ons.find(params[:add_id])
        @order_add_on = @order_item.order_add_ons.new(name: @variation.name, price: @variation.price, description: @variation.description)
      end



    else
      @order_item = @order.order_items.new(name: @menu_item.name, price: @menu_item.price, quantity: 1, menu_item_id: params[:item_id])

      if params.has_key?(:variation_id)
        @variation = @menu_item.variations.find(params[:variation_id])
        @order_item.price = @variation.price # variation price took over primary price
        if @order_item.order_variations.where(order_item_id: params[:item_id]).any?
          @order_item.price = @variation.price
        else
          @order_variation = @order_item.order_variations.new(name: @variation.name, price: @variation.price, description: @variation.description)
        end
      end

      if params.has_key?(:add_id)  
        @add_on = @menu_item.add_ons.find(params[:add_id])
        @order_add_on = @order_item.order_add_ons.new(name: @variation.name, price: @variation.price, description: @variation.description)
      end

      # puts "else"
      # puts @order_item.class
    
    end


    @order.save
    session[:order_id] = @order.id
    
  end
  private
    def order_params
      params.require(:order_item).permit(:sub_total, :delivery_fee, :total)
    end
end
