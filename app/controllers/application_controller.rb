class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  skip_before_action :verify_authenticity_token

  helper_method :login!, :logged_in?, :current_user, :authorized_user?, :logout!

  def login!
    session[:user_id] = @user.id
  end

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorized_user?
    @user == current_user
  end

  def logout!
    session.clear
  end

  def authentication_redirect
    redirect_to root_path unless logged_in?
  end

end
