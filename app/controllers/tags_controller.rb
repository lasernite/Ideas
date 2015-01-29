class TagsController < ApplicationController
  def new
  end


  def show
  	@tag = Tag.find(params[:id])
  end
end
