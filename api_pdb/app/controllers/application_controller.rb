class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include ApiPack::ApiHelper
end
