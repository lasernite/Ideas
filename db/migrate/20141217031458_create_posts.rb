class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :text
      t.tags :text

      t.timestamps
    end
  end
end
