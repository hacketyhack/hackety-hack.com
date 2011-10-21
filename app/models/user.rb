class User
  include MongoMapper::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  key :username, String
  key :email, String
  key :about, String

  many :questions
  many :answers
  
  def to_param
    self.username
  end
  
  def programs
    Program.by_username self.username
  end
  
  #the list of hackers this hacker is following
  key :following_ids, Array
  many :following, :in => :following_ids, :class_name => 'User'

  #the list of hackers that are following this hacker
  key :followers_ids, Array
  many :followers, :in => :followers_ids, :class_name => 'User'

  #after we create a hacker, we want to have them follow steve, and vice versa!
  after_create :follow_steve

  # this method makes the hacker follow the followee
  def follow! followee
    return if following? followee
    following << followee
    save
    followee.followers << self
    followee.save
  end

  # this method makes the hacker unfollow the followee
  def unfollow! followee
    return if !following? followee
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
  
  # Everyone should have at least one follower. And steve would like to follow
  # everyone. So let's do that. This runs after_create.
  def follow_steve
    return if username == "steve"
    steve = User.first(:username => 'steve')
    return if steve.nil?

    follow! steve
    steve.follow! self
  end
end
