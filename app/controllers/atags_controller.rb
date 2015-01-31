class AtagsController < ApplicationController
  def new
  end


  def show
  	@atag = Atag.find(params[:id])
  end
end
