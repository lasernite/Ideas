class WelcomeController < ApplicationController
  def index
  	@posts = Post.all
  	@ptags = Ptag.all
  	@atags = Atag.all
  end
end