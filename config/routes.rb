Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "crypto_currencies#prices"

  get "/crypto_currencies/prices", to: "crypto_currencies#prices"

  get "/orders",         to: "orders#index", as: :orders
  get "/orders/new",     to: "orders#new", as: :new_order
  post "/orders/create", to: "orders#create", as: :create_order
end
