class AtagsController < ApplicationController
  def new
  end


  def show
  	@atag = Tag.find(params[:id])
  end
end
