class PostsController < ApplicationController
  include Twitter::Extractor
  respond_to :html, :js
  def new
  end

  def create
    # Create new post based on posts/_new.html.erb form
  	@post = Post.new(post_params)
    @post.save

    # Get post hashtags: [{:hashtag=>"order", :indices=>[11, 17]}, {:hashtag=>"oh", :indices=>[18, 21]}]
    post_tags = extract_hashtags_with_indices(@post.text)
    # For each tag Hash in post
    post_tags.each do |hash_tag|
      # Save tag as Atag (Unique Tags) if it's not already been added
      @atag = {:tag => hash_tag[:hashtag].downcase}
      unless Atag.all.exists?(@atag)
        Atag.new(@atag).save
      end
      # Save Ptag (Post Tag)
      @ptag = Ptag.new({:hashtag => hash_tag[:hashtag].downcase, :index_start => hash_tag[:indices][0], 
              :index_end => hash_tag[:indices][1], :post_id => @post.id, 
              :atag_id => Atag.find_by(tag:hash_tag[:hashtag].downcase).id })
      @ptag.save
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

end

