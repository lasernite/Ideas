class AtagsController < ApplicationController
  respond_to :html, :js
  def new
  end


  def show
  	@atag = Atag.find(params[:id])
  	# just a note these instance variable names may conflict in move to partial
  	@aptags = Ptag.where(atag_id: @atag.id)
  	@aposts = []
  	@aptags.each do |aptag|
  		@aposts.append(Post.find(aptag.post_id))
  		@aposts = @aposts.uniq
  	end
  end
end
