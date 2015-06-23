class PostsController < ApplicationController
  before_action :only_for_author, only: [:edit, :update]
  before_action :not_logged_in, only: [:upvote, :downvote]
  def show
    @post = Post.includes(:comments).find(params[:id])
    @subs_of_post = @post.subs
    @comments = @post.comments.includes(:child_comments, :author)
    @top_level_comments = @comments.where(parent_comment_id: nil)
    render :show
  end

  def new
    @post = Post.new
    @subs = Sub.all
    @subs_of_post = @post.subs

    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @subs = Sub.all
    @subs_of_post = @post.subs
    @sub_ref = params[:sub_ref]
    if @post.save
      flash[:notice] = "You have successfully made a post!"
      redirect_to sub_url(@sub_ref)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
    @subs_of_post = @post.subs
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    @subs = Sub.all
    @subs_of_post = @post.subs

    if @post.update(post_params)
      flash[:notice] = "You have successfully updated this post!"
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def upvote
    @post_id = params[:post_id]
    @vote = Vote.new(value: 1,
                     votable_type: 'Post',
                     votable_id: @post_id)
    if @vote.save
      flash[:notice] = "You have successfully voted up!"
      redirect_to :back
    else
      flash[:errors] = @vote.errors.full_messages
      redirect_to :back
    end
  end

  def downvote
    @post_id = params[:post_id]
    @vote = Vote.new(value: -1,
                     votable_type: 'Post',
                     votable_id: @post_id)
    if @vote.save
      flash[:notice] = "You have successfully voted down!"
      redirect_to :back
    else
      flash[:errors] = @vote.errors.full_messages
      redirect_to :back
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :url, :content, sub_ids:[])
    end

    def only_for_author
      author = Post.find(params[:id]).author
      unless author == current_user
         flash[:errors] = ["You are not the author of this post."]
         redirect_to post_url(params[:id])
       end
    end
end
