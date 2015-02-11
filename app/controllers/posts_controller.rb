class PostsController < ApplicationController
  respond_to :html, :js
  def new
  end

  def create
    # Create new post based on posts/_new.html.erb form
  	@post = Post.new(post_params)
    if @post.save
      post_spliced = @post.text.split
      post_tags = []
      post_spliced.each do |piece|
        if piece.starts_with?('#')
          post_tags.append(piece[1..-1])
        else
        end
      end

      # For each tag in post
      post_tags.each do |tag|
        # Save tag as Atag (Unique Tags) if it's not already been added
        atag = {:tag => tag.downcase}
        unless Atag.all.exists?(atag)
          Atag.new(atag).save
        end
        # Save Ptag (Post Tag)
        @ptag = Ptag.new({:tag => tag.downcase, :post_id => @post.id, 
                :atag_id => Atag.find_by(tag:tag.downcase).id })
        @ptag.save
      end

      # Create Notification and User (if ze doesn't exist)
      Notification.new(uip:[@post.ip], post_id: @post.id, post_string: @post.text[0..64]).save
      if User.find_by(ip:@post.ip) == nil
        User.new(ip:@post.ip, ncount: 0).save
      else
      end
    else
    end
  	redirect_to '/'
  end

  def show
  	@post = Post.find(params[:id])

    # Splice comments with URLs
    @comments = Comment.where(post_id:@post.id)
    if @comments[0] == nil
      # Borrow someone elses comment
      @comments = Comment.offset(rand(Comment.count))[0..0]
    end

    # Splice posts with hashtags and URLs
    @posts = Post.all
    @posts_spliced = []
    splice_posts(@posts, @posts_spliced)
  end

  def index
  end

  private
    def post_params
  	  params.require(:post).permit(:text, :ip)
    end

    def atag_params
      params.require(:tag)
    end

end

