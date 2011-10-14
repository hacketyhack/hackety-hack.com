class UsersController < InheritedController
  load_and_authorize_resource
  skip_authorize_resource :only => [:following, :followers] #anyone can perform these read-only actions

  def follow
    logger.info "reached follow"
    followee = User.first(:id => params[:user][:followee])
    policy = FollowingPolicy.new(current_user)
    if policy.can_follow? followee
      current_user.follow! followee
      notice = "You're following #{followee.username} now"
    elsif policy.following_self? followee
      notice = "You can't follow yourself silly!"
    elsif policy.already_following? followee
      notice = "You're already following #{followee.username}"
    end
    redirect_to resource_path(followee), :notice=> notice
  end
  
  def unfollow
    followee = User.first(:id => params[:user][:followee])
    current_user.unfollow! followee
    redirect_to resource_path(followee), :notice=> "You're no longer following #{followee.username}"
  end
  
  def following
    @user = User.first(:id => params[:user_id])  
  end
  
  def followers
    @user = User.first(:id => params[:user_id])
  end
  
  
end