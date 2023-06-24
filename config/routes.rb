Rails.application.routes.draw do
  get '/search', to: 'search#index'
  resources :consultations do
    get :export, on: :collection
    post :import, on: :collection
  end
  devise_for :users
  resources :courses do
    get :export, on: :collection
    post :import, on: :collection
  end

  #get 'home/index'
  root 'home#index'

end
