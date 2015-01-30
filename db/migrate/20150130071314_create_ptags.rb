class CreatePtags < ActiveRecord::Migration
  def change
    create_table :ptags do |t|
      t.string :hashtag
      t.integer :index_start
      t.integer :index_end

      t.timestamps
    end
  end
end
