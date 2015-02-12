class Atag < ActiveRecord::Base
	has_many :posts

	def to_param
		tag
	end
end
