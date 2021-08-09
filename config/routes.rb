Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Routes schema

=begin 
  GET /trucks/:id 
    This route should return the truck's info, including it's earnings.
  
  GET /trucks/:id/products
    This route should let you create a new instance of Truck
  
  POST /trucks/:id/buy
    This route should take a json object with a truck id and one or more product_ids
=end

get '/truck/:id', to: 'trucks#financials'
get '/truck/:id/orders', to: 'trucks#orders'
get '/truck/:id/menu', to: 'trucks#menu'
post '/truck/:id/buy', to: 'trucks#buy'
end
