class Comment < ActiveRecord::Base
	default_scope { order(:created_at) }
	belongs_to :post

	validates_length_of :text,
  		:within => 2..11664,
  		:too_short => 'Post too short, 2 character minimum',
  		:too_long => 'Post too long, 11664 character maximum',
  		:message => 'Post is Invalid Length'

  	validate :reasonable_post_count

  	def reasonable_post_count
		if 5 < Comment.where("created_at >= ? AND ip = ?", Time.now - 100, self.ip).size
			errors.add(:ip, 'Sorry mate, gotta let someone else comment for now.')
		end
	end
end
