class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :ip, limit: 8
      t.integer :ncount

      t.timestamps
    end
  end
end
