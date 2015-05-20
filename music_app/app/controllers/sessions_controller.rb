class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:login][:email],
      params[:login][:password]
    )
    
    if user && user.activated?
      log_in_user!(user)
      redirect_to user_url(user)
    elsif user && !user.activated?
      flash.now[:errors] ||= []
      flash.now[:errors] << "Please activate your account."
      render :new
    elsif
      flash.now[:errors] ||= []
      flash.now[:errors] << "Not a valid account."
      render :new
    end

  end

  def destroy
    redirect_to new_session_url if current_user.nil?
    current_user.reset_session_token
    session[:session_token] = nil
    redirect_to new_session_url
  end


end
