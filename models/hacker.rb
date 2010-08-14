#This is the Hacker class. Every user of Hackety Hack gets one!
#most of the stuff in this is based off of then sinatra-authentication plugin.
class Hacker
	#our Hacker model is a full-fledged Document
	include MongoMapper::Document

	#we're storing a unique username
	key :username, String, :unique => true
	#and a unique email
	key :email, String, :unique => true

	#we don't store the passwords themselves, we store a 'hash' of them. More about this down in password=
	key :hashed_password, String
	key :salt, String

	#this is a flag to let us know if this Hacker can administrate the site or not.
	key :admin, Boolean, :default => false

	#the list of hackers this hacker is following
	key :following_ids, Array
	many :following, :in => :following_ids, :class_name => 'Hacker'

	#the list of hackers that are following this hacker
	key :followers_ids, Array
	many :followers, :in => :followers_ids, :class_name => 'Hacker'

	#we don't want to store the password (or the confirmation), so we just make an accessor
	attr_accessor :password, :password_confirmation

	#okay, this is the method that sets the password
	def password=(pass)
		@password = pass
		#okay, we need to get a 'salt'. You can read about salts here: http://en.wikipedia.org/wiki/Salt_(cryptography)
		#basically, we combine the password with the salt, and then encrypt it, and store that in the database.
		#The reason that we do this is because we don't want to keep someone's
		#password in the database, because you never want to write those down!
		#So when we go to look up a password, we can do the same procedure.

		#anyway, let's check if we've got a salt yet. If not, make one.
		self.salt = random_string(10) if !self.salt

		#then, we set the hashed password to the encrypted password + salt.
		self.hashed_password = Hacker.encrypt(@password, self.salt)
	end

	#this method lets will return the user if we've given the right username
	#and password for the user. Otherwise, it returns nil.
	def self.authenticate(username, pass)
		#first we have to dig up the record from the database
		current_user = Hacker.first(:username => username)
		
		#and return nil if we didn't find one.
		return nil if current_user.nil?

		#then, we do the same thing that we did when we stored the hashed password:
		#encrypt the password using the salt, and compare it to the one we saved
		#if they're the same, we know they entered the right password.
		return current_user if Hacker.encrypt(pass, current_user.salt) == current_user.hashed_password

		#if that didn't work, well, you're all out of luck!
		nil
	end

	#this is just a nice helper function to see if a hacker is an admin
	def admin?
		return self.admin == true
	end

	#a helper function for gravatar urls
	def gravatar_url
		require 'md5'
		"http://www.gravatar.com/avatar/#{MD5::md5(email.downcase)}"
	end

	#this function makes the hacker follow the followee
	def follow! followee
		following << followee
		save
		followee.followers << self
		followee.save
	end

	private 

	#we're going to use the SHA1 encryption method for now.
	def self.encrypt(password, salt)
		Digest::SHA1.hexdigest(password + salt)
	end

	#this is a nifty little method to give us a random string of characters
	def random_string(len)
		#first, we make a bunch of random characters in an array
		chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
		newpass = ""
		#then we grab a random element of that array, and add it onto our newpass
		1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
		return newpass
	end
	
end
