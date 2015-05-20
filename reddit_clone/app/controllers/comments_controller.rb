class CommentsController < ApplicationController
  def show
    @comment = Comment.find(params[:id])
    @post_id = @comment.post_id
    render :show
  end

  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @post = @comment.post
    if @comment.save
      flash[:notice] = "You have successfully posted a comment!"
      redirect_to post_url(@post)
    else
      flash[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def upvote
    @comment_id = params[:comment_id]
    @vote = Vote.new(value: 1, votable_type: 'Comment', votable_id: @comment_id)

    if @vote.save
      flash[:notice] = "You have successfully voted up!"
      redirect_to :back
    else
      flash[:errors] = @vote.errors.full_messages
      redirect_to :back
    end
  end

  def downvote
    @comment_id = params[:comment_id]
    @vote = Vote.new(value: -1, votable_type: 'Comment', votable_id: @comment_id)

    if @vote.save
      flash[:notice] = "You have successfully voted down!"
      redirect_to :back
    else
      flash[:errors] = @vote.errors.full_messages
      redirect_to :back
    end
  end
  private
    def comment_params
      params.require(:comment).permit(:content, :post_id, :parent_comment_id)
    end
end
