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


    # If Request has two parts, process apparent search request
    if request.url.split('?').length == 2
      search_request = request.url.split('?')[1].split('+') 
      search_strings = [search_request[0].split('=')[1]] + search_request[1..-1] 
      search_strings.map! do |term| 
       if term == nil
        term = ''
       elsif term.starts_with?('%23') 
         term = term[3..-1] 
       else 
         term 
       end 
      end 

      @searched_posts = []
      search_strings.each do |tag| 
       Ptag.where(tag:tag.downcase).each do |ptag| 
         Post.where(id:ptag.post_id).each do |post|
            @searched_posts.append(post) 
         end 
       end 
      end 
      @posts_spliced_searched = []
      splice_posts(@searched_posts, @posts_spliced_searched)
    else
    end
  end
end