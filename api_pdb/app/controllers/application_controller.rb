# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include ApiPack::ApiHelper
  include Serializable

  before_action :ensure_json_accept,
                :ensure_json_content_type,
                :authorize_request

  attr_reader :current_user

  private

  def ensure_json_accept
    return if request.headers['Accept'] =~ /json/

    render body: nil, status: 406
  end

  def ensure_json_content_type
    return if request.get? || request.headers['Content-Type'] =~ /json/

    render body: nil, status: 415
  end

  def authorize_request
    @current_user = Auth::AuthorizeApiRequest.call(headers: request.headers).data[:user]
  end
end
