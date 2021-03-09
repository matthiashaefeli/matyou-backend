Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :books
  resources :notes
  resources :challenges
  resources :blogs
  resources :comments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
