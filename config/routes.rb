Rails.application.routes.draw do

  resources :organizations do
    resources :environments do
      resources :nodes do
        resources :error_reports
      end
    end
  end

  resources :environments, only: [:status_update], :defaults => {:format => :json} do
    collection do
      get :status_update
    end
  end

  namespace :api, defaults: {format: :json} do
    scope :v1, defaults: {format: :json} do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :projects, only: [:index, :show] do
        resources :prconfigs
        resources :changesets, only: [:index, :show, :create, :add_cookbook, :push] do
          post :add_cookbook
          post :push
          post :notify
        end
        resources :cookbooks, only: [:index, :show, :create]
      end
    end
  end


  resources :projects do
    resources :prconfigs
    resources :cookbooks
    resources :changesets do
      post :build_cookbook
      post :check_pr
      get :stage_status
      get :console
      get :build_details
    end
  end
  # Back admin routes start
  namespace :admin do
    resources :users

    # Admin root
    root to: 'application#index'
  end
  # Back admin routes end

  # Front routes start
  devise_for :users, only: [:session, :registration], path: 'session',
             path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  # Application root
  root to: 'application#home'
  # Front routes end
end
