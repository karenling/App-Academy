class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      @user.reset_session_token!
      log_in_user(@user)
      flash[:notice] = "You have successfuly signed in!"
      redirect_to user_url(@user)
    else
      @user = User.new(user_params)
      flash.now[:errors] = ["Invalid username/password combination."]
      render :new
    end
  end

  def destroy
    log_out_user!
    flash[:notice] = "You have logged out!"
    redirect_to new_session_url
  end

  private
    def user_params
      params.require(:user).permit(:username, :password)
    end
end
