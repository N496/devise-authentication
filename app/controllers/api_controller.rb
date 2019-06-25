class ApiController < ApplicationController
  include ApplicationHelper
  before_action :require_login

  def require_login
    if !params[:auth_token].nil?
      auth_token = AuthToken.find_by(auth_token: params[:auth_token])
      if auth_token.present?
        @current_user = auth_token.user
        true
      else
        unauthorize_http_response('Unable to Authenticate User.')
      end
    else
      unauthorize_http_response('Authentication Token is Missing.')
    end
  end

  def current_user
    @current_user
  end
end
