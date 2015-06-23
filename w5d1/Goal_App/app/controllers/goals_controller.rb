class GoalsController < ApplicationController
  before_action :require_logged_in?
  before_action :check_goal_owner, only: [:destroy, :edit, :update]

  def index
    @goals = Goal.where(private_status: false)
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end


  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    goal = Goal.find(params[:id])
    goal.destroy
    redirect_to user_url(current_user)
  end

  private
  def goal_params
    params.require(:goal).permit(:body, :completed, :private_status)
  end

  def check_goal_owner
    goal = Goal.find(params[:id])
    if goal.user != current_user
      flash[:errors] = ["You're not the owner of this goal."]
      redirect_to :back
    end
  end
end
