# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

truck = Truck.new({name: 'truck', owner: 'park', city: 'montreal', tax_rate: 1.15})
truck.save ? (puts "#{truck.name} was created successfully.") : (puts "#{truck.name} could not save.")
product = Product.new({name: 'Shaved Ice', price: 10.0, stock: 99, type:'IceCream', flavour: 'Chocolate', truck_id: Truck.first.id})
product.save ? (puts "#{product.name} was created successfully.") : (puts "#{product.name} could not save.")

line_items = [LineItem.new(quantity: 1, product_id: product.id, order_id: 0),
              LineItem.new(quantity: 2, product_id: product.id, order_id: 0),
              LineItem.new(quantity: 3, product_id: product.id, order_id: 0)]
prices = []
line_items.each do |item|
  item_price = Product.find(item.product_id).price
  prices.push(item.quantity * item_price)
end
cost_before_tax = prices.sum
sales_tax = truck.tax_rate
cost_after_tax = (cost_before_tax * sales_tax).round(2)
order = Order.new({truck_id: Truck.first.id,
                               cost_before_tax: cost_before_tax,
                               sales_tax: sales_tax,
                               cost_after_tax: cost_after_tax
                               })
puts(order.inspect)
order.save ? (puts "order created successfully. #{order}") : (puts "order could not save. #{order}")
line_items.each do |item|
  item.order_id = order.id
  item.save ? (puts "Item saved. #{item.inspect}") : (puts "Item could not save #{item.errors.full_messages}")
end



