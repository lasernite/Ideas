class ChangeIpLimitOnComments < ActiveRecord::Migration
  def up
    change_column :comments, :ip, :integer, limit: 8
  end

  def down
    change_column :comments, :ip, :integer
  end
end
