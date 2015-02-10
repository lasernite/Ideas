class UsersController < ApplicationController
  def index
  end

  def show
  	@notifications = Notification.all
  	@user = User.find_by(ip:request.remote_ip.split('.').join())
  end
end
