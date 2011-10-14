class FollowingPolicy
  def initialize(follower)
    @follower = follower
  end
  
  def can_follow?(followee)
    !following_self?(followee) && !already_following?(followee)
  end
  
  def already_following?(followee) 
    @follower.following? followee
  end  
  
  def following_self?(followee)
    @follower == followee
  end
end
