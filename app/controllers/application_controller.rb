class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  
  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
  def sign_in(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def redirect_if_not_logged_in
    redirect_to new_session_url unless logged_in?
  end
  
end
