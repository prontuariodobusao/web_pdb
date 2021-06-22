Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root to: 'initial#index'

  post 'auth/login', to: 'authentication#authenticate'

  resources :users, only: %i[index show] do
    resource :confirmation, only: :create
  end
end
