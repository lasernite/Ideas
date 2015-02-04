class CreatePtags < ActiveRecord::Migration
  def change
    create_table :ptags do |t|
      t.string :tag
      t.integer :post_id
      t.integer :atag_id

      t.timestamps
    end
  end
end
