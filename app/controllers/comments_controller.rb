class CommentsController < ApplicationController
  respond_to :html, :js

  def index
    @request_pieces = request.path.split('/')
    # Find comments for post and splice
    @comments = Comment.where(post_id:@request_pieces[2])

    @post = [Post.find(@request_pieces[2])]
    @post_spliced = []
    splice_posts_full(@post, @post_spliced)
  end

  def create
  	# Create new comment based on comments/_new.html.erb form
  	@comment = Comment.new(comment_params)
    @comment.save

    # Increase all users in notification count (notification)
    @notification = Notification.find_by(post_id:@comment.post_id)
    @notification.uip.uniq.each do |uip|
      User.find_by(ip:uip).increment!(:ncount)
    end
    # Add commenter to notification
    @notification.update_attributes(uip: @notification.uip + [request.remote_ip.split('.').join()])

    # @posts_path = '/posts/' + @comment.post_id.to_s
    @comments = Comment.where(post_id:@comment.post_id)
  	render 'posts/show'
  end

  def show
  end


  private
    def comment_params
  	  params.require(:comment).permit(:text, :post_id, :ip)
    end
end
