class PostsController < ApplicationController
  include Twitter::Extractor

  def new
  end

  def create
    # Create new post based on posts/_new.html.erb form
  	@post = Post.new(post_params)
    @post.save
    # get hashtags ex. [{:hashtag=>"order", :indices=>[11, 17]}, {:hashtag=>"oh", :indices=>[18, 21]}]
    post_tags = extract_hashtags_with_indices(@post.text)

    # Format each Hash in post_tags and save {:hashtag=>"example", :index_start=>11, :index_end=>19}
    post_tags.each do |hash_tag|
      @ptag = Ptag.new({:hashtag => hash_tag[:hashtag].downcase, :index_start => hash_tag[:indices][0], 
              :index_end => hash_tag[:indices][1], :post_id => @post.id})
      @ptag.save

      # Add tag in post to Tags if it's not already been added
      @atag = {:tag => hash_tag[:hashtag].downcase}
      unless Atag.all.exists?(@atag)
        Atag.new(@atag).save
      end
    end
    
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

end

