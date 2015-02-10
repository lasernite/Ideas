class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :uip, limit: 8, array: true
      t.integer :post_id
      t.string :post_string

      t.timestamps
    end
  end
end
