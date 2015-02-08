class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :text
      t.integer :ip, :limit => 8

      t.timestamps
    end
  end
end
