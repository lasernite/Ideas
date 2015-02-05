class CommentsController < ApplicationController
  respond_to :html, :js
  def index
  end

  def create
  	# Create new comment based on comments/_new.html.erb form
  	@comment = Comment.new(comment_params)
    @comment.save
    # @posts_path = '/posts/' + @comment.post_id.to_s
    @comments = Comment.where(post_id:@comment.post_id)
  	render 'posts/show'
  end

  def show
  end


  private
    def comment_params
  	  params.require(:comment).permit(:text, :post_id)
    end
end
