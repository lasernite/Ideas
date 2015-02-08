class Post < ActiveRecord::Base
	default_scope { order(:id) }
	belongs_to :tag
	has_many :ptags
	has_many :comments

	validates_length_of :text,
  		:within => 4..11664,
  		:too_short => 'Post too short, 4 character minimum',
  		:too_long => 'Post too long, 11664 character maximum',
  		:message => 'Post is Invalid Length'

  	validate :reasonable_post_count

  	def reasonable_post_count
		if 5 < Post.where("created_at >= ? AND ip = ?", Time.now - 500, self.ip).size
			errors.add(:ip, 'Sorry mate, gotta let someone else post for now.')
		end
	end
end