class AddToCart
  attr_reader :order, :params, :menu_item
  attr_accessor :order_item, :variation, :session

  def self.call(order:, params:, session:)
    self.new(order: order, params: params, session: session).call
  end
  
  def initialize(order:, params:, session:)
    @order = order
    @params = params
    @session = session
    @menu_item = MenuItem.find(params[:item_id])
    @variation = menu_item.variations.find_by(id: params[:variation_id])
    @order_items = order.order_items.where(menu_item: menu_item,variation: params[:variation_id])
    
    @order_item = @order_items.take
    
    if variation.present?
      if params[:add_ids].present?
        @order_item = fetch_order_item_by_add_on
      else
        @order_item = order.order_items.where(menu_item: menu_item, variation_id: params[:variation_id]).take
      end
    else
      @order_item = fetch_order_item_by_add_on
    end

  end

  # fetch order_item according to add_ons
  def fetch_order_item_by_add_on
    
    existing_item = false
    @order_items.joins(:add_ons).each do |oi|
      if oi.add_ons.pluck('id') == params[:add_ids].map(&:to_i)
        @order_item = order.order_items.find(oi.id)
        existing_item = true
        break
      end
    
    end
      
    if !existing_item
      @order_item = nil
    end

    return @order_item
  end

  def call
    if order_item.present?
      return handle_existing_order_item 
    else
      return add_new_order_item
    end
  end

  private
    def add_new_order_item
      price = menu_item.price
      price = variation.price if variation.present?
      
      if variation.present?
        @order_item = order.order_items.new(name: menu_item.name, price: price, quantity: 1, menu_item: menu_item, variation: variation)
      else  
        @order_item = order.order_items.new(name: menu_item.name, price: price, quantity: 1, menu_item: menu_item)
      end

      order.save
      session[:order_id] = order.id

      return add_add_ons if params[:add_ids].present?
      
      return order

    end

    def add_add_ons
      params[:add_ids].each do |ad_on|
        add_on = menu_item.add_ons.find(ad_on)
        order_item.order_add_ons.new(name: add_on.name, price: add_on.price, description: add_on.description, add_on: add_on).save!

      end
      
      return order
    
    end

    def handle_existing_order_item
      if variation.present?
        if order_item.present?
          return handle_existing_order_variation if params[:add_ids].present?
          update_quantity
        else 
          return add_new_order_item
        end
      else
        update_quantity
      end
        return order
    end

    def handle_existing_order_variation
      
      if order_item.present?
        update_quantity
      else
        add_new_order_item
      end
      
      return order
    end

    def update_quantity
      order_item.update(quantity: order_item.quantity+1)
      order.save
    end
end