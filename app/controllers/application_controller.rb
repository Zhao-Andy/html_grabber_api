class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :restrict_access, except: [:root, :login, :signup, :destroy]

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  private

  def restrict_access
    authenticate_or_request_with_http_token do |api_key, options|
      @user = User.find_by(api_key: api_key, email: request.headers['X-User-Email'])
    end
  end
end
