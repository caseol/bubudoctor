Rails.application.routes.draw do
  resources :patients
  # config/routes.rb
  get "/pages/*id" => 'pages#show', as: :page, format: false

  # if routing the root path, update for your controller
  root to: 'pages#show', id: 'about'

  #root to: 'visitors#index'
  devise_for :users
  resources :users
end
