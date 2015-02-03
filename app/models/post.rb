class Post < ActiveRecord::Base
	belongs_to :tag
	has_many :ptags

	validates_length_of :text,
  		:within => 4..21012,
  		:too_short => 'Post too short, 4 character minimum',
  		:too_long => 'Post too long, 21012 character maximum',
  		:message => 'Post is Invalid Length'
end
