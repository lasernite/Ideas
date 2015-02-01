class AtagsController < ApplicationController
  respond_to :html, :js
  def new
  end


  def show
  	@atag = Atag.find(params[:id])
  	# Get all unique posts with tag, store as @aposts
  	@aptags = Ptag.where(atag_id: @atag.id)
  	@aposts = []
  	@aptags.each do |aptag|
  		@aposts.append(Post.find(aptag.post_id))
  		@aposts = @aposts.uniq
  	end

  	# Build all aposts as items in @aposts_spliced, with each item an @apost_pieces array
  	@ptags = Ptag.all
  	@atags = Atag.all

  	@aposts_spliced = []
  	# Build all posts as items in @aposts_spliced, with each item an @apost_pieces array
  	@aposts.reverse.each do |post| 
        @tag_indices = [] 
        @tag_links = [] 

        # For each of the ptags associated with post 
        @ptags.where(post_id:post.id).each do |ptag| 
       		# Store hashtag's start/stop indices for splicing post 
         	@tag_indices.append([ptag.index_start, ptag.index_end]) 
        	# Store hashtag links for splicing post
         	@tag_links.append(view_context.link_to '#' + ptag.hashtag, atag_path(Atag.find_by(id:ptag.atag_id).id), 
            :class => 'post_hashtag', :remote => true)
    	end 

        # Create and store post as @apost_pieces in @aposts_spliced
        # If there are no hashtags, just store text
        if @tag_indices.length == 0 
      		@aposts_spliced.append([post.text])

      	# Elsif there is one hahstag, splice it and store 
       	elsif @tag_indices.length == 1 
       		if post.text[0] == '#' 
      			@aposts_spliced.append([post.text[2..@tag_indices[0][0]], @tag_links[0], 
      			post.text[@tag_indices[0][1]..-1]]) 
      	 	else 
      	   		@aposts_spliced.append([post.text[0..@tag_indices[0][0]-2], @tag_links[0], 
      	   		post.text[@tag_indices[0][1]..-1]])
      		end  

      	# Else there are multiple hashtags, splice them in and store 
       	else 
       		# Reset counter for number of tags in this post
		 	@tag_count = 0 

		 	# If post begins with tag, no text before first tag
		 	if @tag_indices[0][0] == 0 
		   		@apost_pieces = []
		   	# Else store text before first tag
		 	else 
		   		@apost_pieces = [post.text[0..@tag_indices[0][0]-2]] 
		 	end 

		 	# Build core of @apost_pieces, splicing together tags and text
		   	@tag_indices.each do |indice| 
		  	 	@apost_pieces.append(@tag_links[@tag_count]) 
		  	 	@apost_pieces.append(post.text[indice[1]..@tag_indices[@tag_count+1][0]-2]) 
		  	 	if @tag_count < (@tag_indices.length-2) 
		  		 	@tag_count += 1 
		  	 	else
		  	 		# Do nothing
		  	 	end 
		   	end 

		   	# Knock off the junk at the end
		   	@apost_pieces.pop 
		   	@apost_pieces.pop 

		   	# Finish compiling @apost_pieces and store it in @aposts_spliced
		   	@apost_pieces.append(@tag_links[-1])
		  	@apost_pieces.append(post.text[@tag_indices[-1][1]..-1])
		  	@aposts_spliced.append(@apost_pieces)
	    end 				  
 	  end

  end
end
