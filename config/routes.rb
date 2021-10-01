Rails.application.routes.draw do
   get 'home/about' => "homes#about"
  root to:'homes#index'
  
  
  devise_for :users

  resources :homes
  
  resources :users
    resources :books
  
end
