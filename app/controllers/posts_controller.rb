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
    else
    end
  	redirect_to '/'
  end

  def show
  	@post = Post.find(params[:id])
  end

  def index
  end

  private
    def post_params
  	  params.require(:post).permit(:text)
    end

    def atag_params
      params.require(:tag)
    end

end

