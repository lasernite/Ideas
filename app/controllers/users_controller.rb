class UsersController < ApplicationController
  def index
  end

  def show
  	@user = User.find_by(ip:request.remote_ip.split('.').join())
  	@notifications = Notification.where("? = ANY (uip)", @user.ip).reverse
  end
end
