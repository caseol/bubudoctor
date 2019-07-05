Rails.application.routes.draw do
  resources :exams
  devise_for :users
  resources :users, path: "u", path_names: { edit: "e", new: "novo" }
  resources :appointments, path: "consulta", path_names: { edit: "e", new: "novo" }
  resources :patients, path: "p", path_names: { edit: "e", new: "novo" } do
    get :autocomplete_patient_name, on: :collection
  end

  get '/protocolo' => 'protocol#protocol', as: :protocol#, format: false
  get '/historico/*id' => 'protocol#historic', as: :historic#, format: false

  # config/routes.rb
  get "/pages/*id" => 'pages#show', as: :page, format: false

  # if routing the root path, update for your controller
  root to: 'pages#show', id: 'about'

  #root to: 'visitors#index'

end
