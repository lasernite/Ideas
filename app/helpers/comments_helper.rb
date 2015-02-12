module CommentsHelper
	def splice_comments(comments, spliced) 
	 	comments.each do |comment| 
	   		comment_spliced = comment.text.split 
	   		comment_spliced.map! do |piece| 
				# Map in tag link for #tag
	  			if piece.starts_with?('#')
          			unless piece == nil
  	  					link_to(piece.downcase, atag_path(Atag.find_by(tag:piece[1..-1].downcase)),
  	  					:class => 'post_hashtag', :remote => true, :onclick => "location.href='#top'")
          			end
		   		# Map in URL link 
	     		elsif piece.starts_with?('www.','http://','https://') 
	       			link_to(piece, piece, target: '_blank') 
	       		# Map in /t/community links
        		elsif piece.downcase.starts_with?('/t/')
          			link_to(piece, piece)
		   		# Map regular string piece back to string 
	     		else 
	       			piece 
	     		end 
	   		end 
	   		spliced.append(comment_spliced) 
	 	end 
	end
end
