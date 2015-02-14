class AddAtagIndexToPtags < ActiveRecord::Migration
  def change
  	add_index :ptags, :atag_id
  end
end
