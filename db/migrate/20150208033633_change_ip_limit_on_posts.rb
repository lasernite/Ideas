class ChangeIpLimitOnPosts < ActiveRecord::Migration
  def up
    change_column :posts, :ip, :integer, limit: 8
  end

  def down
    change_column :posts, :ip, :integer
  end
end
