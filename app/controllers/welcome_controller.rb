class WelcomeController < ApplicationController
  def create
  	@post = Post.new
  end

  def index
  	@posts = Post.all
  end
end