Rails.application.routes.draw do
  resources :topics
  devise_for :users
  root 'home#index'
  resources :books
  resources :notes
  resources :challenges
  resources :blogs
  resources :comments
  resource :topics
  get 'data/books', to: 'data#books'
  get 'data/notes', to: 'data#notes'
  get 'data/challenges', to: 'data#challenges'
  get 'data/blogs', to: 'data#blogs'
  get 'data/book/:id', to: 'data#book'
  get 'data/topics', to: 'data#topics'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
