require_relative '../app/models/following_policy'

describe FollowingPolicy do
  before(:each) do 
    @followed = stub()
    @follower = stub()
  end
  
  it 'can follow another' do
    @follower.should_receive(:following?).with(@followed).and_return(false)
    policy = FollowingPolicy.new(@follower, @followed)
    policy.can_follow?.should be_true
  end
  
  it "cannot follow self" do
    policy = FollowingPolicy.new(@follower, @follower)
    policy.can_follow?.should be_false
  end
  
  it "cannot follow twice" do
    @follower.should_receive(:following?).with(@followed).and_return(true)
    policy = FollowingPolicy.new(@follower,@followed)
    policy.can_follow?.should be_false
  end
  
end