class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  
  before_action :require_login
  
  def require_login
    authenticate_token || render_unauthorized("Access denied")
  end

  def current_user
    @current_user ||= authenticate_token
  end

  protected

  def render_unauthorized(message)
    errors = { errors: [ { detail: message } ] }
    render json: errors, status: :unauthorized
  end

  private

  def authenticate_token
    # Authorization header format: "Authorization: Token token=<your-token-here>"
    authenticate_with_http_token do |token, options|
      User.find_by(token: token)
    end
  end  
end
