class TrucksController < ApplicationController
  before_action :set_truck, only: [:buy, :financials, :orders, :menu]

  def buy
    orderered_items = JSON.parse(request.body.read)
    line_items = []
    prices = []

    orderered_items.each do |_key, value|
      quantity = value["quantity"].to_i
      id = value["id"]
      product = Product.find(id)
      if product.stock >= quantity
        line_items.push(LineItem.new({product_id: id,
                                      quantity: quantity
                                      }))
        product.stock -= quantity
        product.save ? (puts "#{product.name} stock updated"): (puts product.errors.full_messages)
        else
          return render json: {
            message: "Sorry, but we're out of #{product.name}."
          }
        end
      end
    
    line_items.each do |item|
      item_price = Product.find(item.product_id).price
      prices.push(item.quantity * item_price)
    end

    cost_before_tax = prices.sum
    tax_rate = @truck.tax_rate
    cost_after_tax = (cost_before_tax * tax_rate).round(2)
    sales_tax = cost_after_tax - cost_before_tax
    order = Order.new({truck_id: Truck.first.id,
                                   cost_before_tax: cost_before_tax,
                                   sales_tax: sales_tax,
                                   cost_after_tax: cost_after_tax
                                   })
    order.save ? (puts "order created successfully. #{order.inspect}") : (puts "order could not save. #{order.errors.full_messages}")
    line_items.each do |item|
      item["order_id"] = order.id
      item.save ? (puts "Item saved. #{item.inspect}") : (puts "Item could not save #{item.errors.full_messages}")
      end
    
     render json: {
       message: "Enjoy!",
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
        menu: @truck.products.all.map{|p| {product_name: p.name, price: p.price}}
      }
  end


  private

  def trucks_params
    params.require(:truck).permit(:name, :owner, :city)
  end

  def set_truck
    @truck = Truck.find(params[:id])
  end
end
