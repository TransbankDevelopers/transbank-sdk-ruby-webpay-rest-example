Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



  root to: 'product_index#index'

  get 'webpayplus/create', to: 'webpay#create'
  post 'webpayplus/create', to: 'webpay#send_create'
  post '/webpayplus/return_url', to: 'webpay#commit'

end
