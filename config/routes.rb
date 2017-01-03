Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    scope :v1, defaults: {format: :json} do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :projects, only: [:index, :show] do
        resources :changesets, only: [:index, :show, :create, :add_cookbook, :push] do
          post :add_cookbook
          post :push
          post :notify
        end
        resources :cookbooks, only: [:index, :show]
      end
    end
  end

  resources :projects do
    resources :cookbooks
    resources :changesets do
      post :build_cookbook
      post :check_pr
      get :stage_status
      get :console
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
