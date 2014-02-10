require 'spec_helper'

describe User do

  let(:bob){Fabricate(:user)}
  let(:mozart){Fabricate(:user)}

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
end