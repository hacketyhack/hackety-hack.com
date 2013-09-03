class User
  include MongoMapper::Document
  #****many :authentications
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :omniauthable, :recoverable, :rememberable, :trackable, :validatable

  many :authentications #*****Trying this thru Line 12 JFTFOI 

  #field :name, :type => String
  #field :provider, :type => String

  validates_uniqueness_of :email #****Trying this thru Line 52 JFTFOI 
  #attr_accessible :email, :password, :password_comfirmation, :remember_me, :username 
  attr_protected :uid, :name, :email
  #index({email: 1}, {background: true,  unique: true})
  #index({"authentications.provider" => 1}, {background: true})
  #index({"authentications.uid" => 1}, {background: true})
  def self.create_with_omniauth(auth)
  create! do |user|
    user.provider = auth['provider']
    user.uid = auth['uid']
    if auth['info']
       user.name = auth['info']['name'] || ""
       user.email = auth['info']['email'] || ""
    end
  end
end
  def self.new_with_session(params, session) ## When Omniauth is generating user data, this methid is requested
    if session["devise.user_attributes"]
      auth = session["devise.user_attributes"]
      new do |user|
        user.name = auth['info']['name'] unless auth['info']['name'].blank?
        user.name ||= auth['info']['nickname'] unless auth['info']['nickname'].blank?
        user.name ||= auth['info']['first_name'] + ''+ auth['info']['last_name'] unless auth['info']['first_name'].blank? || auth['last_name'].blank?

        user.email = auth['info']['email'] unless auth['info']['email'].blank?

        user.provider = auth['provider']

        #This password stuff is a complete hack (Lines 33-36)
        user.password, user.password_comfirmation =alid auth['credentials']['token']
        user.valid?
      end
    else
      super
    end

    def pasword_required?
      super && provider.blank?
    end

    def update_with_password(params, *options)
      if encrypted_password.blank?
        update_attributes(params, *options)
      else
        super
      end
    end
  end


  validates_presence_of :username
  validates_uniqueness_of :username
  
  key :username, String
  key :email, String
  key :about, String
  key :moderator, Boolean
  key :blog_poster, Boolean
  
  ## Omniauthable
  key :provider, String
  key :uid,      String
  

  ## Database authenticatable
  key :email,              :type => String, :null => false
  key :encrypted_password, :type => String, :null => false

  ## Recoverable
  key :reset_password_token,   :type => String
  key :reset_password_sent_at, :type => Time

  ## Rememberable
  key :remember_created_at, :type => Time

  ## Trackable
  key :sign_in_count,      :type => Integer
  key :current_sign_in_at, :type => Time
  key :last_sign_in_at,    :type => Time
  key :current_sign_in_ip, :type => String
  key :last_sign_in_ip,    :type => String

  many :questions
  many :answers

  validates_format_of :username, :with => /^[\w\.]+$/,
    :message => "Make your username from letters, numbers, underscores('_'), and dots('.')."
  validates_length_of :username, :in => (1..32),
    :message => "Your username needs at least 1 character but no more than 32."
  validates_uniqueness_of :username,
    :message => "User name has been taken already. Please try another"

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


  def self.from_omniauth(auth)
    ## Trying this JFTFOI
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.id
      user.email = auth.info.email
      user.firstname = auth.info.first_name
      user.lastname = auth.info.last_name
      # here we'll try first_or_... -- if that doesn't work we'll try find_or_ ...

      #user = User.find_or_initialize_by_provider_and_uid(auth[:provider], auth[:uid])
      user.username = auth.info.nickname
    # if they are trying authentication for the first time ever, 
    #   the save will fail due to validation failure
      user.save
      user

    end   
    
  end

  def password_required?
    super && provider.blank?
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]  
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
end
