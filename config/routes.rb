Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'product_index#index'

  get 'webpayplus/create', to: 'webpay#create'
  post 'webpayplus/create', to: 'webpay#send_create'
  post '/webpayplus/return_url', to: 'webpay#commit'
  post '/webpayplus/refund', to: 'webpay#refund'
  get '/webpayplus/status/:token', to: 'webpay#status'

  get 'webpayplus/diferido/create', to: 'webpay_deferred#create'
  post 'webpayplus/diferido/create', to: 'webpay_deferred#send_create'
  post 'webpayplus/diferido/return_url', to: 'webpay_deferred#commit'
  post 'webpayplus/diferido/capture', to: 'webpay_deferred#capture'
  get 'webpayplus/diferido/status/:token', to: 'webpay_deferred#status'
  post "/webpayplus/diferido/refund", to: 'webpay_deferred#refund'

  get '/webpayplus/mall/create', to: 'webpay#mall_create'
  post '/webpayplus/mall/create', to: 'webpay#send_mall_create'
  post '/webpayplus/mall/return_url', to: 'webpay#mall_commit'
  get '/webpayplus/mall/status/:token', to: 'webpay#mall_status'
  post '/webpayplus/mall/refund', to: 'webpay#mall_refund'


  get '/webpayplus/mall/diferido/create', to: 'webpay_mall_deferred#create'
  post '/webpayplus/mall/diferido/create', to: 'webpay_mall_deferred#send_create'
  post '/webpayplus/mall/diferido/return_url', to: 'webpay_mall_deferred#commit'
  post 'webpayplus/mall/diferido/capture', to: 'webpay_mall_deferred#capture'
  get '/webpayplus/mall/diferido/status/:token', to: 'webpay_mall_deferred#status'
  post '/webpayplus/mall/diferido/refund', to: 'webpay_mall_deferred#refund'

  get '/oneclick/mall/inscription/start', to: 'oneclick_mall#inscription'
  post '/oneclick/mall/inscription/start', to: 'oneclick_mall#start_inscription'
  post '/oneclick/mall/inscription/finish', to: 'oneclick_mall#finish_inscription'
  delete '/oneclick/mall/inscription', to: 'oneclick_mall#delete_inscription'


  post '/oneclick/inscription/response_url', to: 'oneclick_mall#finish_inscription'

  post '/oneclick/mall/authorize', to: 'oneclick_mall#authorize'
  post '/oneclick/mall/status', to: 'oneclick_mall#status'
  post '/oneclick/mall/refund', to: 'oneclick_mall#refund'

  get '/patpass/patpass_by_webpay/create', to: 'patpass#create'
  post '/patpass/patpass_by_webpay/create', to: 'patpass#send_create', as: :send_create
  post '/patpass/patpass_by_webpay/return_url', to: 'patpass#commit'
  get '/patpass/patpass_by_webpay/status/:token', to: 'patpass#status'

  get '/patpass/patpass_comercio/inscription', to: 'patpass_comercio#inscription'
  post '/patpass/patpass_comercio/inscription', to: 'patpass_comercio#start_inscription'
  post '/patpass/patpass_comercio/inscription/status', to: 'patpass_comercio#inscription_status'
  post '/patpass/patpass_comercio/final_url', to: 'patpass_comercio#final_url'

  get '/transaccion_completa/create', to: 'transaccion_completa#create'
  post '/transaccion_completa/create', to: 'transaccion_completa#send_create'
  post '/transaccion_completa/installments', to: 'transaccion_completa#installments'
  post '/transaccion_completa/commit', to: 'transaccion_completa#commit'
  get  '/transaccion_completa/status/:token', to: 'transaccion_completa#status'
  post '/transaccion_completa/refund', to: 'transaccion_completa#refund'

  get '/transaccion_completa/mall/create', to: 'transaccion_completa_mall#create'
  post '/transaccion_completa/mall/create', to: 'transaccion_completa_mall#send_create'
  post '/transaccion_completa/mall/installments', to: 'transaccion_completa_mall#installments'
  post '/transaccion_completa/mall/commit', to: 'transaccion_completa_mall#commit'
  get  '/transaccion_completa/mall/status/:token', to: 'transaccion_completa_mall#status'
  post '/transaccion_completa/mall/refund', to: 'transaccion_completa_mall#refund'


end
