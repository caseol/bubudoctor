Rails.application.routes.draw do
  devise_for :users
  resources :users, path: "u", path_names: { edit: "e", new: "novo" }
  resources :appointments, path: "consulta", path_names: { edit: "e", new: "novo" }
  resources :patients, path: "p", path_names: { edit: "e", new: "novo" }

  get 'protocol/protocol'
  get 'protocol/historic'

  # config/routes.rb
  get "/pages/*id" => 'pages#show', as: :page, format: false

  # if routing the root path, update for your controller
  root to: 'pages#show', id: 'about'

  #root to: 'visitors#index'

end
