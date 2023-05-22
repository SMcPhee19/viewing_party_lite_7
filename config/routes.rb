# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', controller: 'users', to: 'users#new'
  post '/register', controller: 'users', to: 'users#create'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  
  resources :users do
    resources :discover, only: [:index], controller: 'users/discover'
    resources :movie, only: %i[index show], controller: 'users/movies' do
      # resources :movie, only: %i[index show] do
      resources :viewing_parties, only: %i[new create], controller: 'users/viewing_parties'
    end
  end
  # resources :viewing_parties
  #  resources :user_viewing_parties, controller: 'users/user_viewing_parties'
  # resources :user_viewing_parties
end
