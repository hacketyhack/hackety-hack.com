require "digest/sha1"

class AddApiKeyToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :api_key, :string
		User.all.each do |u|
			u.api_key = Digest::SHA1.hexdigest(Time.now.to_s + rand(12341234).to_s)[1..16]
			u.save
		end
  end

  def self.down
    remove_column :users, :api_key
  end
end
