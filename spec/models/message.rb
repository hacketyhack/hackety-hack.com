require 'spec_helper'

describe Message do
  subject {Fabricate.build(:message)}

  describe '#to_param' do
    it 'has the email attribute' do
      subject.to_param[:email].should == subject.email
    end

    it'has the subject attribute' do
      subject.to_param[:subject].should == subject.subject
    end

    it 'has the body attribute' do
      subject.to_param[:body].should == subject.body
    end
  end
end