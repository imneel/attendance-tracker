Rails.application.routes.draw do
  devise_for :admins
  resources :attendances, only: [:index, :create]
  resources :users, only: [:new, :create, :show, :destroy]
  get '/home' => 'home#index', as: 'home'
  get '/charts' => 'attendances#charts', as: 'charts'

  root to: 'home#index'
end
