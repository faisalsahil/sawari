Rails.application.routes.draw do

  # default_url_options :host => "'http://localhost:3000"

  devise_for :users
  # match '/users/:id/destroy', to: 'users#destroy', via: [:get, :patch], as: 'signout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  # mount Ckeditor::Engine => '/ckeditor'
  
  resources :users do
    collection do
      post 'add_user'
    end
    member do
      put  'update_user'
    end
  end
  resources :projects do
    resources :categories
  end

  resources :categories do
    resources :end_points
  end

  resources :settings do
    collection do
      get 'projects'
      get 'users'
      post 'create_user_projects'
    end
  end

  resources :clients do
    collection {
      post :import
    }
  end
  
  resources :templates do
    member {
      get :send_mail
      post :send_mail_confirm
      resources :email_histories
    }
  end

  resources :email_histories, only:[] do
    member {
      get :send_email
      post :send_mail_confirm
    }
  end


  root to:'users#index'
end
