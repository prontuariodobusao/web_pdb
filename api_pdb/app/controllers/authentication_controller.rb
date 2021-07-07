# app/controllers/api/authentication_controller.rb
class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  def authenticate
    auth_token =
      Auth::Authenticate.call(username: auth_params[:username], password: auth_params[:password]).data[:token]
    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:username, :password)
  end
end
