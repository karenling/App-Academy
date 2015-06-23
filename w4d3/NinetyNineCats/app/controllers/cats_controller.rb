class CatsController < ApplicationController
  before_action :user_must_own_cat_to_edit, only: [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else

      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def user_must_own_cat_to_edit
    cat = Cat.find_by(id: params[:id])
    if cat.nil? || current_user.nil?
      # flash[:errors]= "You must log in first to edit this cat."
      redirect_to new_session_url
    elsif cat && current_user.id != cat.user_id
      flash[:errors] = "Sorry, you can't update a cat that isn't yours. You've been redirect to the main page."
      redirect_to cats_url
    end
  end

  def cat_params
    params.require(:cat)
      .permit(:age, :birth_date, :color, :description, :name, :sex)
  end
end
