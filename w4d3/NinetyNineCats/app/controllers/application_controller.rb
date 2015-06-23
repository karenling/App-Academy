class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    current_session = Session.find_by(session_token: session[:session_token])
    return nil unless current_session
    User.find(current_session.user_id)

    # User.find_by(session_token: session[:session_token])
  end

  # def login!(session)
  #   session[:session_token] = session.session_token
  # end

  def redirect_to_cats_index_if_current_user
    redirect_to cats_url if current_user
  end
end
