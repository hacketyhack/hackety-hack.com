class UsersController < InheritedController
  load_and_authorize_resource
  skip_authorize_resource :only => [:following, :followers] #anyone can perform these read-only actions

  def follow
    followee = User.first(:id => params[:user][:followee])
    if current_user == followee
      redirect_to resource_path(followee), :notice=> "You can't follow yourself silly!"
      return
    end
    current_user.follow! followee
    redirect_to resource_path(followee), :notice=> "You're following #{followee.username} now"
  end
  
  def unfollow
    followee = User.first(:id => params[:user][:followee])
    current_user.unfollow! followee
    redirect_to resource_path(followee), :notice=> "You're no longer following #{followee.username}"
  end
  
end