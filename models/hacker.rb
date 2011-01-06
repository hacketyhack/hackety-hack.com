#This is the Hacker class. Every user of Hackety Hack gets one!
#most of the stuff in this is based off of then sinatra-authentication plugin.
class Hacker
  include MongoMapper::Document

  key :username, String, :unique => true
  key :email, String, :unique => true

  key :about, String

  #we don't store the passwords themselves, we store a 'hash' of them. More about this down in password=
  key :hashed_password, String
  key :salt, String

  key :admin, Boolean, :default => false

  #the list of hackers this hacker is following
  key :following_ids, Array
  many :following, :in => :following_ids, :class_name => 'Hacker'

  #the list of hackers that are following this hacker
  key :followers_ids, Array
  many :followers, :in => :followers_ids, :class_name => 'Hacker'

  #after we create a hacker, we want to have them follow steve, and vice versa!
  after_create :follow_steve

  #we don't want to store the password (or the confirmation), so we just make an accessor
  attr_accessor :password, :password_confirmation

  # This method sets our password. The first thign we need to get a 'salt'. You 
  # can read about salts [here](http://en.wikipedia.org/wiki/Salt_(cryptography\)).
  # basically, we combine the password with the salt, and then encrypt it, and 
  # store that in the database.
  #
  # The reason that we do this is because we don't want to keep someone's
  # password in the database, because you never want to write those down!
  # So when we go to look up a password, we can do the same procedure.
  def password=(pass)
    @password = pass

    self.salt = random_string(10) if !self.salt

    self.hashed_password = Hacker.encrypt(@password, self.salt)
  end

  # This method lets will return the user if we've given the right username
  # and password for the user. Otherwise, it returns nil.
  def self.authenticate(username, pass)
    current_user = Hacker.first(:username => username)

    return nil if current_user.nil?

    # then, we do the same thing that we did when we stored the hashed password:
    # encrypt the password using the salt, and compare it to the one we saved
    # if they're the same, we know they entered the right password.
    return current_user if Hacker.encrypt(pass, current_user.salt) == current_user.hashed_password

    # if that didn't work, well, you're all out of luck!
    nil
  end

  # this is just a nice helper function to see if a hacker is an admin
  def admin?
    return self.admin == true
  end

  # a helper function for gravatar urls
  def gravatar_url
    require 'digest/md5'
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}"
  end

  # this method makes the hacker follow the followee
  def follow! followee
    following << followee
    save
    followee.followers << self
    followee.save
  end

  # this method makes the hacker unfollow the followee
  def unfollow! followee
    following_ids.delete(followee.id)
    save
    followee.followers_ids.delete(id)
    followee.save
  end

  # this method returns true if we're following the given Hacker, and
  # false otherwise
  def following? hacker
    following.include? hacker
  end

  # this method looks up the programs for a given user
  def programs
    Program.all(:creator_username => username)
  end

  private

  # we're going to use the SHA1 encryption method for now.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest(password + salt)
  end

  # this is a nifty little method to give us a random string of characters
  def random_string(len)
    # first, we make a bunch of random characters in an array
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    # then we grab a random element of that array, and add it onto our newpass
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end

  # Everyone should have at least one follower. And I'd like to follow
  # everyone. So let's do that. This runs after_create.
  def follow_steve
    return if username == "steve"
    steve = Hacker.first(:username => 'steve')
    return if steve.nil?

    follow! steve
    steve.follow! self
  end

end
