class UsersController < ApplicationController
  def index
    if params[:only]
      @users = User.limit(params[:only])
    else
      @users = User.all
    end
    render json: @users
  end

  def new
    render json: params
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render(
        json: @user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      render json: @user
    else
      render(
        json: @user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: @user
  end

  def update_favorites
    @user = User.find(params[:id])
    
  end


  def favorites
    @user = User.find(params[:id])
    @our_contacts = @user.contacts.where(favorite: true)
    @shared_contacts = @user.contact_shares.where(favorite: true)

    render json: @our_contacts + @shared_contacts
  end

  private
    def user_params
      params.require(:user).permit(:username)
    end
end
