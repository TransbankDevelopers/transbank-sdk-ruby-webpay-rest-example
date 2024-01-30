Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: 'product_index#index'
  get '/oneclick_mall/start', to: 'oneclick_mall#start'
  get '/oneclick_mall/finish', to: 'oneclick_mall#finish'
  delete '/oneclick_mall/delete', to: 'oneclick_mall#delete'
  get '/oneclick_mall/authorize', to: 'oneclick_mall#authorize'
  get '/oneclick_mall/status', to: 'oneclick_mall#status'
  post '/oneclick_mall/refund', to: 'oneclick_mall#refund'
  get '/oneclick_mall/refund', to: 'oneclick_mall#show_refund'

  get '/oneclick_mall_deferred/start', to: 'oneclick_mall_deferred#start'
  get '/oneclick_mall_deferred/finish', to: 'oneclick_mall_deferred#finish'
  delete '/oneclick_mall_deferred/delete', to: 'oneclick_mall_deferred#delete'
  get '/oneclick_mall_deferred/authorize', to: 'oneclick_mall_deferred#authorize'
  get '/oneclick_mall_deferred/status', to: 'oneclick_mall_deferred#status'
  post '/oneclick_mall_deferred/refund', to: 'oneclick_mall_deferred#refund'
  get '/oneclick_mall_deferred/refund', to: 'oneclick_mall_deferred#show_refund'
  post '/oneclick_mall_deferred/capture', to: 'oneclick_mall_deferred#capture'
  get '/oneclick_mall_deferred/capture', to: 'oneclick_mall_deferred#show_capture'
  # post '/oneclick_mall_deferred/increase_amount', to: 'oneclick_mall_deferred#increase_amount'
  # post '/oneclick_mall_deferred/reverse', to: 'oneclick_mall_deferred#reverse'
  # post '/oneclick_mall_deferred/increase_date', to: 'oneclick_mall_deferred#increase_date'
  # post '/oneclick_mall_deferred/history', to: 'oneclick_mall_deferred#history'
end
