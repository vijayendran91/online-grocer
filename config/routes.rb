Rails.application.routes.draw do
  resources :users
  root "users#home"

  get 'user/login', :to => 'sessions#login'
  post 'user/login', :to=> 'sessions#verify_creds'
  get 'user/verify_otp', :to=> 'sessions#verify_otp'
  post 'user/verify_otp', :to=> 'sessions#verify_otp'
  delete 'user/logout', :to=> 'sessions#logout'

  get 'user/account_settings', :to => 'users#account_settings'
  get 'user/cart', :to => 'orders#cart'
  post 'user/new_address', :to=> 'users#new_address'
  post 'order/add_to_cart', :to => 'orders#add_to_cart'
  post 'order/remove_from_cart', :to=> 'orders#remove_from_cart'
  get 'order/checkout', :to=> 'orders#checkout'
  post 'order/order_confirmation', :to=> 'orders#submit_order'
  get 'order/icart', :to=> 'orders#icart'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  #Admin
  get 'qwe/admin', :to=> 'admin#admin_home'
  get 'qwe/admin/items_list', :to=> 'admin#items_list'
  post 'qwe/admin/new_item', :to=> 'admin#new_item'
  get 'qwe/admin/orders_list', :to => 'admin#orders_list'
end
