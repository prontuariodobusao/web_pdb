# app/controllers/api/authentication_controller.rb
class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  def authenticate
    auth_token =
      Auth::Authenticate.call(identity: auth_params[:identity], password: auth_params[:password]).data[:token]
    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:identity, :password)
  end
end
