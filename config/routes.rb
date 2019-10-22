Rails.application.routes.draw do
  post '/d/new_and_associate' => 'diseases#new_and_associate_patient', as: :new_and_associate_patient, format: :js
  resources :diseases, path: "d", path_names: { edit: "e", new: "novo" } do
    get :autocomplete_disease_code, on: :collection
    get ':patient_id/associate' => 'diseases#associate_patient', as: :associate_patient
    delete ':patient_id/delete' => 'diseases#delete_associate_patient', as: :delete_associate_patient
  end
  resources :consultations
  resources :exams
  devise_for :users, :controllers => { :registrations => :registrations }
  resources :users, path: "u", path_names: { edit: "e", new: "novo" }
  resources :appointments, path: "consulta", path_names: { edit: "e", new: "novo" }
  resources :patients, path: "p", path_names: { edit: "e", new: "novo" } do
    get :autocomplete_patient_all, on: :collection
  end

  get '/protocolo' => 'protocol#protocol', as: :protocol#, format: false
  get '/historico/*id' => 'protocol#historic', as: :historic#, format: false

  # config/routes.rb
  get "/pages/*id" => 'pages#show', as: :page, format: false

  # if routing the root path, update for your controller
  root to: 'pages#show', id: 'about'

  delete "/file/:id" => 'application#delete_file', as: :delete_file

  #root to: 'visitors#index'

end
