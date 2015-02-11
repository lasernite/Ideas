class UsersController < ApplicationController
  def index
  end

  def show
  	# Get user by IP
  	@user = User.find_by(ip:request.remote_ip.split('.').join())
  	# Get most recent notifications (12) and all notifications associated with IP
  	@notifications = Notification.where("? = ANY (uip)", @user.ip).reverse[0..8]
  	@all_notifications = Notification.where("? = ANY (uip)", @user.ip).reverse.paginate(:page => params[:page], :per_page => 12)
  end
end
