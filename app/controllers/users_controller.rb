class UsersController < InheritedController
  load_and_authorize_resource
  skip_authorize_resource :only => [:following, :followers, :deleted_user] #anyone can perform these read-only actions
  require 'will_paginate/array'

  def index
    redirect_to root_path unless can? :manage, @users
    @users = User.all.paginate(:page => params[:page], :per_page => 10)
  end

  def follow
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
    @user = User.first(:username => params[:user_id])
  end

  def followers
    @user = User.first(:username => params[:user_id])
  end

  def deleted_user
    @user = DeletedUser.new
  end

  #################

  def resource
    @user ||= end_of_association_chain.find_by_username(params[:id])
  end

end

