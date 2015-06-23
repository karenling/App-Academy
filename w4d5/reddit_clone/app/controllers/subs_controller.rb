class SubsController < ApplicationController
  before_action :only_for_moderator, only: [:edit, :update]
  before_action :not_logged_in, only: [:create, :new]


  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      flash[:notice] = "You have successfuly created a subforum!"
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      flash[:notice] = "You have successfully updated your subforum."
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private
    def only_for_moderator
      sub = Sub.find(params[:id])
      unless current_user == sub.moderator
        flash[:errors] = ["You are not the moderator for this sub."]
        redirect_to :back
      end
    end
    def sub_params
      params.require(:sub).permit(:title, :description)
    end
end
