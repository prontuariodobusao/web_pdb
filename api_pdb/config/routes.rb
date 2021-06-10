Rails.application.routes.draw do
  root to: 'initial#index'

  post 'auth/login', to: 'authentication#authenticate'

  resources :users
end
