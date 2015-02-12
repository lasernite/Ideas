class Atag < ActiveRecord::Base
	has_many :posts

	def to_param
		"#{id}-#{tag}"
	end
end
