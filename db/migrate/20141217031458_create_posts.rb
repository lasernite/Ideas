class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :text
      t.integer :ip

      t.timestamps
      change_column :posts, :ip, :limit => 8
    end
  end
end
