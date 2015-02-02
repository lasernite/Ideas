class WelcomeController < ApplicationController
  respond_to :html, :js
  def index
  	@posts = Post.all
  	@ptags = Ptag.all
  	@atags = Atag.all

  	@posts_spliced = []
  	# Build all posts as items in @posts_spliced, with each item an @post_pieces array
  	@posts.reverse.each do |post| 
        @tag_indices = [] 
        @tag_links = [] 

        # For each of the ptags associated with post 
        @ptags.where(post_id:post.id).each do |ptag| 
       		# Store hashtag's start/stop indices for splicing post 
         	@tag_indices.append([ptag.index_start, ptag.index_end]) 
        	# Store hashtag links for splicing post
         	@tag_links.append(view_context.link_to '#' + ptag.hashtag, atag_path(Atag.find_by(id:ptag.atag_id).id), 
            :class => 'post_hashtag', :remote => true, :onclick => "location.href='#top'")
    	end 

        # Create and store post as @post_pieces in @posts_spliced
        # If there are no hashtags, just store text
        if @tag_indices.length == 0 
      		@posts_spliced.append([post.text])

      	# Elsif there is one hahstag, splice it and store 
       	elsif @tag_indices.length == 1 
       		if post.text[0] == '#' 
      			@posts_spliced.append([post.text[2..@tag_indices[0][0]], @tag_links[0], 
      			post.text[@tag_indices[0][1]..-1]]) 
      	 	else 
      	   		@posts_spliced.append([post.text[0..@tag_indices[0][0]-2], @tag_links[0], 
      	   		post.text[@tag_indices[0][1]..-1]])
      		end  

      	# Else there are multiple hashtags, splice them in and store 
       	else 
       		# Reset counter for number of tags in this post
		 	@tag_count = 0 

		 	# If post begins with tag, no text before first tag
		 	if @tag_indices[0][0] == 0 
		   		@post_pieces = []
		   	# Else store text before first tag
		 	else 
		   		@post_pieces = [post.text[0..@tag_indices[0][0]-2]] 
		 	end 

		 	# Build core of @post_pieces, splicing together tags and text
		   	@tag_indices.each do |indice| 
		  	 	@post_pieces.append(@tag_links[@tag_count]) 
		  	 	@post_pieces.append(post.text[indice[1]..@tag_indices[@tag_count+1][0]-2]) 
		  	 	if @tag_count < (@tag_indices.length-2) 
		  		 	@tag_count += 1 
		  	 	else
		  	 		# Do nothing
		  	 	end 
		   	end 

		   	# Knock off the junk at the end
		   	@post_pieces.pop 
		   	@post_pieces.pop 

		   	# Finish compiling @post_pieces and store it in @posts_spliced
		   	@post_pieces.append(@tag_links[-1])
		  	@post_pieces.append(post.text[@tag_indices[-1][1]..-1])
		  	@posts_spliced.append(@post_pieces)
	    end 				  
 	  end


    # Get the 50 most used Atags in the past 24hrs based on Ptags
    # Get Ptags created within past 24hrs (86400 seconds)
    @recent_ptags = Ptag.where("created_at >= ?", Time.now - 86400)
    # Store tags recently created
    @recent_ptags_hashtags = []
    @recent_ptags.each do |ptag|
      @recent_ptags_hashtags.append(ptag.hashtag)
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