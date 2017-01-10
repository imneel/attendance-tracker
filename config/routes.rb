Rails.application.routes.draw do
  devise_for :admins
  resources :attendances, only: [:index, :create]
  resources :users, only: [:new, :create, :show, :destroy]
  get '/home' => 'home#index', as: 'home'

  root to: 'home#index'
end
