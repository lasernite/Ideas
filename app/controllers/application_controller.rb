class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def splice_posts(posts, spliced)
  	# Split each post and map each piece of post to hashtag or URL if applicable
  	posts.each do |post|
  		post_spliced = post.text.downcase.split
  		post_spliced.map! do |piece|
  			# Map in tag link for #tag
	  		if piece.starts_with?('#')
          unless piece == nil
  	  			view_context.link_to(piece, atag_path(Atag.find_by(tag:piece[1..-1]).id),
  	  								:class => 'post_hashtag', :remote => true, 
  	  								:onclick => "location.href='#top'")
          end
	  		# Map in URL link
	  		elsif piece.starts_with?('www.','http://','https://')
	  			view_context.link_to(piece, piece, target: '_blank')
	  		# Map regular string piece back to string
	  		else
	  			piece
	  		end
  		end
  		# Append post id to end for comment routing
  		post_spliced.append(post.id)
  		# Append the split mapped post to array of such posts
  		spliced.append(post_spliced)
  	end
  end
end
