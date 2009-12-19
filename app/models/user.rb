class User < ActiveRecord::Base
	acts_as_authentic
	
	has_many :watchings
	has_many :watches, :through => :watchings
end
