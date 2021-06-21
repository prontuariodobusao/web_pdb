Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root to: 'initial#index'

  post 'auth/login', to: 'authentication#authenticate'

  resources :users, only: :index do
    resource :unlok, only: :create
  end
end
