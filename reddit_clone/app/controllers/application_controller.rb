class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :moderator?, :author?

  def current_user
    user = User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def log_in_user(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out_user!
    current_user.reset_session_token! unless current_user.nil?
    session[:session_token] = nil
  end

  def not_logged_in
    unless logged_in?
      flash[:errors] = ["Please log in!"]
      redirect_to new_session_url
    end
  end

  def only_current_user
    user = User.find(params[:id])
    render json: "You cannot view another user's private page" unless current_user == user
  end

  def moderator?
    sub = Sub.find(params[:id])
    sub.moderator == current_user
  end

  def author?
    post = Post.find(params[:id])
    post.author == current_user
  end


end
