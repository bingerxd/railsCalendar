Rails.application.routes.draw do
  get '/search', to: 'search#index'
  resources :consultations
  devise_for :users
  resources :courses

  #get 'home/index'
  root 'home#index'

end
