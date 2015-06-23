class CommentsController < ApplicationController
  def index
    @commentable = find_commentable
    @comments = @commentable.comments

    render json: @comments
  end


  private
    def find_commentable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end
end
