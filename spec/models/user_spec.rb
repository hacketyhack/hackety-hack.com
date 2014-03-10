require 'spec_helper'

describe User do
  let(:bob){Fabricate(:user, :username => 'hacker')}
  let(:mozart){Fabricate(:user)}
  let(:hello_world){Fabricate(:program, :author_username => bob.username)}
  
  it 'can be created validly' do
    bob.should be_valid
    mozart.should be_valid
  end

  it 'Users can follow and unfollow' do
    bob.follow!(mozart)
    bob.following?(mozart).should be_true
    bob.unfollow!(mozart)
    bob.reload
    bob.following?(mozart).should be_false
  end

  describe 'programs' do
    it 'should return programs list' do
      bob.programs.class.should == Plucky::Query
      hello_world.author_username.should == 'hacker'
      bob.username.should == 'hacker'
      bob.programs.count.should == 1
      bob.programs.first.should == hello_world
    end
  end
end