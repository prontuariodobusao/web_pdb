Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root to: 'initial#index'

  post 'auth/login', to: 'authentication#authenticate'

  resources :users, only: [] do
    resource :confirmation, only: :create
  end

  resources :categories, only: [] do
    get 'problems', on: :member
  end

  namespace :manager do
    resources :users, except: %i[destroy index] do
      get 'locked', on: :member
      get 'unlock', on: :member
    end
    resources :orders, except: %i[destroy create] do
      get 'edit', on: :member
    end

    resources :employees, except: :destroy
  end

  resources :orders, except: %i[destroy update]
end
