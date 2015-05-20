class UsersController < ApplicationController
  before_action :admin?, only: [:index, :make_admin]
  before_action :logged_in?, only: [:index]

  def make_admin
    @user = User.find(params[:id])
    @user.update(admin: true)
    redirect_to users_url
  end
  def index
    @users = User.all
    render :index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.activation_email(@user).deliver
      log_in_user!(@user)
      # session[:session_token] = @user.session_token
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def activate
    flash[:notice] ||= []
    user = User.find_user_by_activation_token(params[:activation_token])
    redirect_to new_session_url if user.nil?
    if user && user.activated?
      flash[:notice] << "You have already activated your account! Please log in."
      redirect_to new_session_url
    end

    if user && !user.activated?
      user.toggle!(:activated)
      flash[:notice] << "Your account is now activated!"
      log_in_user!(user)
      redirect_to user_url(user)
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
