Rails.application.routes.draw do
  get 'attendances/index'

  get 'attendances/create'

  get 'users/new'

  get 'users/destroy'

  get 'users/show'

  get '/home' => 'home#index', as: 'home'

  root to: 'home#index'
end
