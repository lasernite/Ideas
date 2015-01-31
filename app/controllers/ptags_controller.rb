class PtagsController < ApplicationController
	def show
		@ptag = Ptag.find(params[:id])
	end
end
