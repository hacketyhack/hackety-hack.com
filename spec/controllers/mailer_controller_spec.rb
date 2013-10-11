require 'spec_helper'

describe MailerController do
  let(:user) { Fabricate(:user) }
  let(:users) { Fabricate.sequence(:user, 5)}

  describe "GET 'new' for a single user email" do
    it "returns http success" do
      get 'new', user: Array(user)
      response.should be_success
    end
  end

  describe "GET 'new' for a diffusion" do
    it "returns http success" do
      get 'new', user: Array(users)
      response.should be_success
    end
  end

  describe "POST 'create' for a single user email" do
    it "returns http success" do
      @message = Fabricate.build(:message)
      post 'create', message: @message
      response.should be_success
      #We expect after send a message that the deliveries raise one
      expect { MessageMailer.new_message(@message, @message.email).deliver }.to change { ActionMailer::Base.deliveries.size }.by(1)
    end
  end

  describe "POST 'create' for a diffusion" do
    it "returns http success" do
      @diffusion = Fabricate.build(:diffusion)
      post 'create', message: @diffusion
      response.should be_success

      @before_send = ActionMailer::Base.deliveries.size
      @diffusion.email.each do |email|
        MessageMailer.new_message(@diffusion, email).deliver
      end
      ActionMailer::Base.deliveries.size.should eq @before_send + @diffusion.email.size
    end
  end
end
