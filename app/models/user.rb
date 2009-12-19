class User < ActiveRecord::Base
	acts_as_authentic
	
	has_many :watchings
	has_many :watches, :through => :watchings
	
	has_many :messages
	has_many :recipients, :through => :messages
	
	has_many :inverse_messages, :class_name => "Message", :foreign_key => "recipient_id"
	has_many :inverse_recipients, :through => :inverse_messages, :source => :users

	has_many :programs
end
