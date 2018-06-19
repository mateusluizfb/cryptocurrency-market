Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "crypto_currencies#prices"

  get :prices, to: "crypto_currencies#prices"
end
