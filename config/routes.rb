Rails.application.routes.draw do
  resources :users
  root "users#home"

  get 'user/login', :to => 'sessions#login'
  post 'user/login', :to=> 'sessions#verify_creds'
  get 'user/verify_otp', :to=> 'sessions#verify_otp'
  post 'user/verify_otp', :to=> 'sessions#verify_otp'
  delete 'user/logout', :to=> 'sessions#logout'
  get 'user/cart', :to => 'users#cart'


  post 'order/add_to_cart', :to => 'orders#add_to_cart'
  post 'order/remove_from_cart', :to=> 'orders#remove_from_cart'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  #Admin
  get 'qwe/admin', :to=> 'admin#admin_home'
  get 'qwe/admin/item_list', :to=> 'admin#item_list'
  post 'qwe/admin/new_item', :to=> 'admin#new_item'
end
