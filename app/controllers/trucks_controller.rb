# frozen_string_literal: true

class TrucksController < ApplicationController
  before_action :set_truck, only: %i[buy financials orders menu]
  
  def buy
    ordered_items = JSON.parse(request.body.read)
    line_items = fetch_items(ordered_items)
    prices = fetch_prices(line_items)
    order = build_and_save_order(prices)
    update_and_save_items(line_items, order)
    
    render json: {
      message: 'Enjoy!',
      your_order: order
    }
  end

  def financials
    render json: {
      name: @truck.name,
      owner: @truck.owner,
      earnings: "$#{@truck.orders.sum(&:cost_after_tax)}"
    }
  end

  def orders
    render json: {
      trx_history: @truck.orders.all
    }
  end

  def menu
    render json: {
      menu: @truck.products.all.map { |p| { product_name: p.name, price: p.price } }
    }
  end

  private

  def trucks_params
    params.require(:truck).permit(:name, :owner, :city)
  end

  def set_truck
    @truck = Truck.find(params[:id])
  end

  def build_and_save_order(prices)
    cost_before_tax = prices.sum
    tax_rate = @truck.tax_rate
    cost_after_tax = (cost_before_tax * tax_rate).round(2)
    sales_tax = cost_after_tax - cost_before_tax
    order = Order.new({ truck_id: @truck.id,
                        cost_before_tax: cost_before_tax,
                        sales_tax: sales_tax,
                        cost_after_tax: cost_after_tax })
    raise "order could not save. #{order.errors.full_messages}" unless order.save
    order
  end

  def fetch_prices(line_items)
    prices = []
    line_items.each do |item|
      item_price = Product.find(item.product_id).price
      prices.push(item.quantity * item_price)
    end
    prices
  end

  def fetch_items(ordered_items)
    line_items = []
    ordered_items.each do |_key, value|
      quantity = value['quantity'].to_i
      id = value['id']
      product = Product.find(id)
      raise "Sorry, but we're out of stock for #{product.name}." unless product.stock >= quantity
      update_product_stock(product, quantity)
      line_items.push(LineItem.new({ product_id: id, quantity: quantity }))
    end
    line_items
  end
  
  def update_product_stock(product, quantity)
    product.stock -= quantity
    raise "#{product.errors.full_messages}" unless product.save
  end

  def update_and_save_items(line_items, order)
    line_items.each do |item|
      item.order_id = order.id
      raise "Item could not save #{item.errors.full_messages}" unless item.save
    end
  end
end
