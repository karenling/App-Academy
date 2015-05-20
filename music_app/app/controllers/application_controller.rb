class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :admin?


  def log_in_user!(user)
    user.reset_session_token
    user.save
    session[:session_token] = user.session_token
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
    # return if user.nil?
    # return user
  end


  def logged_in?
    if current_user.nil?
      flash[:errors] = ["You must be logged in to view this."]
      redirect_to new_session_url
    end
  end

  def admin?
    if current_user.nil?
      return nil
    elsif !current_user.admin
      render text: "You cannot do that because you're not an admin.", status: :forbidden
    else
      return true
    end
  end
end
