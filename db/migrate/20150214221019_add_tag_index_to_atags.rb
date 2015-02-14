class AddTagIndexToAtags < ActiveRecord::Migration
  def change
  	add_index :atags, :tag
  end
end
