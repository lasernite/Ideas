module CommentsHelper
	def splice_comments(comments, spliced) 
	 	comments.each do |comment| 
	   		comment_spliced = comment.text.split 
	   		comment_spliced.map! do |piece| 
		   		# Map in URL link 
	     		if piece.starts_with?('www.','http://','https://') 
	       			link_to(piece, piece, target: '_blank') 
		   		# Map regular string piece back to string 
	     		else 
	       			piece 
	     		end 
	   		end 
	   		spliced.append(comment_spliced) 
	 	end 
	end
end
