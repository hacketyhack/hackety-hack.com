require_relative '../app/models/following_policy'

describe FollowingPolicy do
  before(:each) do 
    @followee = double 'followee'
    @follower = double 'follower'
  end
  
  it 'can follow another' do
    @follower.should_receive(:following?).with(@followee).and_return(false)
    policy = FollowingPolicy.new(@follower)
    policy.can_follow?(@followee).should be_true
  end
  
  it "cannot follow self" do
    policy = FollowingPolicy.new(@follower)
    policy.following_self?(@follower).should be_true
    policy.can_follow?(@follower).should be_false
  end
  
  it "cannot follow twice" do
    @follower.should_receive(:following?).twice.with(@followee).and_return(true)
    policy = FollowingPolicy.new(@follower)
    policy.already_following?(@followee).should be_true
    policy.can_follow?(@followee).should be_false
  end
  
end
