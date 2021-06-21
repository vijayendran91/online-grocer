Rails.application.routes.draw do
  resources :users
  root "users#home"

  get 'user/login', :to => 'sessions#login'
  post 'user/login', :to=> 'sessions#new_session'
  delete 'user/logout', :to=> 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
