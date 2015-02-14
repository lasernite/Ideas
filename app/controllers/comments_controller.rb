class CommentsController < ApplicationController
  respond_to :html, :js

  def index
    @request_pieces = request.path.split('/')
    # Find comments for post and splice
    @comments = Post.find(@request_pieces[2]).comments

    @post = [Post.find(@request_pieces[2])]
    @post_spliced = []
    splice_posts_full(@post, @post_spliced)
  end

  def create
  	# Create new comment based on comments/_new.html.erb form
  	@comment = Comment.new(comment_params)
    @comment.save
    # @posts_path = '/posts/' + @comment.post_id.to_s
    @comments = Post.find(@comment.post_id).comments
    render 'posts/show'

    # Create user if they don't already exist
    @ip = @comment.ip
    if User.find_by(ip:@ip) == nil
      User.new(ip:@ip, ncount: 0).save
    else
    end
    # Increase all users in notification count (notification), except commenter
    @notification = Notification.find_by(post_id:@comment.post_id)
    @notification.uip.uniq.each do |uip|
      unless uip == @ip
        User.find_by(ip:uip).increment!(:ncount)
      end
    end
    # Add commenter to notification
    @notification.update_attributes(uip: @notification.uip + [@ip])
  end

  def show
  end


  private
    def comment_params
  	  params.require(:comment).permit(:text, :post_id, :ip)
    end
end
