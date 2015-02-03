class Comment < ActiveRecord::Base
	belongs_to :post

	validates_length_of :text,
  		:within => 4..11664,
  		:too_short => 'Post too short, 4 character minimum',
  		:too_long => 'Post too long, 11664 character maximum',
  		:message => 'Post is Invalid Length'
end
