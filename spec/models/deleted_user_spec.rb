require 'spec_helper'

describe DeletedUser do
  
  before do
    @user = DeletedUser.new
  end

  it 'has deleted username' do
    @user.username.should == 'Deleted User'
  end

  it 'has no email' do
    @user.email.should == 'none'
  end

  it 'returns deleted user param' do
    @user.to_param.should == 'deleted_user'
  end
end