class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
