class CommentsController < ApplicationController
  def index
  end

  def create
  	# Create new comment based on comments/_new.html.erb form
  	@comment = Comment.new(comment_params)
  	# Relate comment to post
  	# @comment.post_id = 
    @comment.save
  	redirect_to '/'
  end


  private
    def comment_params
  	  params.require(:comment).permit(:text, :post_id)
    end
end
