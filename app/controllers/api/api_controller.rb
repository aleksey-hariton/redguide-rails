module Api
  class ApiController < ActionController::Base
    include DeviseTokenAuth::Concerns::SetUserByToken
    # protect_from_forgery with: :null_session

    before_action :authenticate_user!
  end
end
