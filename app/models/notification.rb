class Notification < ActiveRecord::Base
	default_scope { order(:updated_at) }
end
