class CreateWatchings < ActiveRecord::Migration
  def self.up
    create_table :watchings do |t|
      t.integer :user_id
      t.integer :watches_id

      t.timestamps
    end
  end

  def self.down
    drop_table :watchings
  end
end
