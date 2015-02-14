class Atag < ActiveRecord::Base
	has_many :posts
	has_many :ptags

	def to_param
		tag
	end
end
