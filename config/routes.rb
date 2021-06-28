Rails.application.routes.draw do
  resources :users
  root "users#home"

  get 'user/login', :to => 'sessions#login'
  post 'user/login', :to=> 'sessions#verify_creds'
  get 'user/verify_otp', :to=> 'sessions#verify_otp'
  post 'user/verify_otp', :to=> 'sessions#verify_otp'
  delete 'user/logout', :to=> 'sessions#logout'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  #Admin
  get 'user/qwe/admin', :to=> 'admin#admin_home'
end
