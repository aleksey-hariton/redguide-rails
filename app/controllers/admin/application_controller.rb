module Admin
  class ApplicationController < ActionController::Base
    # include DeviseTokenAuth::Concerns::SetUserByToken
    # protect_from_forgery with: :exception
    protect_from_forgery with: :null_session

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!

    layout :layout_by_resource

    def index
      render 'application/home'
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit(:password, :password_confirmation, :current_password, :name)
      end
    end

    private def layout_by_resource
      if devise_controller?
        'layouts/devise'
      else
        'admin/layouts/admin'
      end
    end
  end
end
