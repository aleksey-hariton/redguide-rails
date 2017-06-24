class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def home
    unless user_signed_in?
      redirect_to '/session/login'
    end
  end
end
