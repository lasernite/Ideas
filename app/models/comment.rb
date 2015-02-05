class Comment < ActiveRecord::Base
	belongs_to :post

	validates_length_of :text,
  		:within => 2..11664,
  		:too_short => 'Post too short, 2 character minimum',
  		:too_long => 'Post too long, 11664 character maximum',
  		:message => 'Post is Invalid Length'
end
