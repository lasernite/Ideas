class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :post_id
      t.integer :parent_id
      t.integer :ip, :limit => 8

      t.timestamps
    end
  end
end
