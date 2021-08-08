Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Routes schema

=begin 
  GET /trucks/:id 
    This route should return the truck's info, including it's earnings.
  
  POST /trucks
    This route should let you create a new instance of Truck
  
  POST /trucks/:id/products
    This route should let you create a new instance of Product

  POST /customers
    This route should let you create a new instance of Customer

  POST /customers/:id/shopping_carts
    This route should let you create a new instance of a shopping_cart / transaction

  POST /categories
    This route should let you create a new instance of a product category

  POST /types
    This route should let you create a new instance of a product type 
    (flavour of ice cream and shaved ice, type of snack)

  If deemed necessary, UPDATE and DELETE routes for the above models could be added as well.
=end 
end
