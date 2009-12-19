class Watching < ActiveRecord::Base
	belongs_to :user
	belongs_to :watches, :class_name => "User"
end
