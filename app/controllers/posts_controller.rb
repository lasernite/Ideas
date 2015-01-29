class PostsController < ApplicationController
  include Twitter::Extractor

  def new
  end

  def create
  	@post = Post.new(post_params)
  	@post.save
    post_tags = extract_hashtags_with_indices(@post.text)
    @tag = Tag.new(tag_params)
    @tag.save
  	redirect_to '/'
  end

  def show
  	@post = Post.find(params[:id])
  end

  def index
  	@posts = Post.all
  end

  private
    def post_params
  	  params.require(:post).permit(:text)
    end

    def tag_params
      post_tags = extract_hashtags_with_indices(@post.text)
      params.require(:post).permit(post_tags)
    end

end

