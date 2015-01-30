class CreateAtags < ActiveRecord::Migration
  def change
    create_table :atags do |t|
      t.string :tag

      t.timestamps
    end
  end
end
