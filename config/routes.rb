Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'product_index#index'

  get 'webpayplus/create', to: 'webpay#create'
  post 'webpayplus/create', to: 'webpay#send_create'
  post '/webpayplus/return_url', to: 'webpay#commit'
  post '/webpayplus/refund', to: 'webpay#refund'
  get '/webpayplus/status/:token', to: 'webpay#status'

  get '/webpayplus/mall/create', to: 'webpay#mall_create'
  post '/webpayplus/mall/create', to: 'webpay#send_mall_create'
  post '/webpayplus/mall/return_url', to: 'webpay#mall_commit'
end
