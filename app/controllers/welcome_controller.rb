class WelcomeController < ApplicationController
  respond_to :html, :js
  def index
  	@posts = Post.all
  	@ptags = Ptag.all
  	@atags = Atag.all
    @comments = Comment.all

    # Build all posts as items in @posts_spliced, with each item a post_pieces array
  	@posts_spliced = []
  	splice_posts(@posts, @posts_spliced)

    # Get the 50 most used Atags in the past 24hrs based on Ptags
    # Get Ptags created within past 24hrs (86400 seconds)
    @recent_ptags = Ptag.where("created_at >= ?", Time.now - 86400)
    # Store tags recently created
    @recent_ptags_hashtags = []
    @recent_ptags.each do |ptag|
      @recent_ptags_hashtags.append(ptag.tag)
    end
    # Count the number of occurences of each tag and store with unique hashtag
    @recent_tags_count = Hash.new(0)
    @recent_ptags_hashtags.each do |tag|
      @recent_tags_count[tag] += 1
    end
    # Save hash as array in order of number of tag occurences, largest first 
    @recent_tags = @recent_tags_count.sort_by {|key,value| -value}
    # Get only top 50
    @recent_tags = @recent_tags[0..49]

  end
end