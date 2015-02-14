class Ptag < ActiveRecord::Base
	belongs_to :post
	belongs_to :atag
end
