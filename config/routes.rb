Rails.application.routes.draw do
  resources :lists
  resources :careers
  resources :topics
  devise_for :users
  root 'home#index'
  resources :books
  resources :notes
  resources :challenges
  resources :blogs
  resources :comments
  resource :topics
  resources :lists
  resource :careers do
    post :send_email, on: :member
  end
  namespace :data do
    resources :books, only: [:index, :show]
    resources :notes, only: [:index]
    resources :topics, only: [:index]
    resources :challenges, only: [:index]
    resources :cmds, only: [:index]
    resources :lists, only: [:index]
    resources :blogs, only: [:index]
  end
end
