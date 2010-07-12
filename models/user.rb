#most of the stuff in this is based off of sinatra-authentication
class User
	include MongoMapper::Document
	key :username, String, :unique => true
	key :email, String, :unique => true
	key :hashed_password, String
	key :salt, String
	key :admin, Boolean, :default => false

	attr_accessor :password, :password_confirmation

	def password=(pass)
		@password = pass
		self.salt = random_string(10) if !self.salt
		self.hashed_password = User.encrypt(@password, self.salt)
	end

	def self.authenticate(username, pass)
		current_user = User.first(:username => username)
		return nil if current_user.nil?
		return current_user if User.encrypt(pass, current_user.salt) == current_user.hashed_password
		nil
	end

	def admin?
		return self.admin == true
	end
	

	private 
	def self.encrypt(password, salt)
		Digest::SHA1.hexdigest(password + salt)
	end

	def random_string(len)
		chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
		newpass = ""
		1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
		return newpass
	end
	
end
