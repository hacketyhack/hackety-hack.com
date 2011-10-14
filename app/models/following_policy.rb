class FollowingPolicy
  def initialize(follower, target)
    @follower = follower
    @target = target
  end
  
  def can_follow?
    !following_self? && !already_following?
  end
  
  def already_following?
    @follower.following?(@target)
  end  
  
  def following_self?
    @follower == @target
  end
end