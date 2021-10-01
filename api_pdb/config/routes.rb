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
    resources :users, only: %i[show update] do
      get 'locked', on: :member
      get 'unlock', on: :member
      get 'reset_password', on: :member
      post 'add_or_remove_role', on: :member, as: :roles
    end

    resources :orders, except: %i[destroy create] do
      get 'edit', on: :member
      get '/panel', to: 'orders#panel', on: :collection
    end

    resources :employees, except: %i[destroy index] do
      resources :users, only: :create
      # get '/list(/:type_occupation)', to: 'employees#index', on: :collection
      get '/list', to: 'employees#index', on: :collection
      post 'datatable', to: 'employees#datatable', on: :collection
    end

    namespace :charts do
      get 'report'
      post 'report_by_dates'
      post 'report_mecanic_by_dates'
      post 'report_employee_problems_by_dates'
    end

    resources :vehicles, except: :destroy do
      post 'datatable', to: 'vehicles#datatable', on: :collection
      get 'revisions', to: 'vehicles#revisions', on: :collection
    end
  end

  resources :orders, except: %i[destroy update]
end
