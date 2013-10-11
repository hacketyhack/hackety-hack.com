require 'spec_helper'

describe MailerController do
  let(:user) { Fabricate(:user) }
  let(:users) { Fabricate.sequence(:user, 5)}

  describe "GET 'new' for a single user email" do
    it "returns http success" do
      get :new, user: Array(user)
      response.should be_success
    end
  end

  describe "GET 'new' for a diffusion" do
    it "returns http success" do
      get :new, user: Array(users)
      response.should be_success
    end
  end

  describe "POST 'create' for a single user email" do
    before :each do
      @message = Fabricate.build(:message)
    end

    it 'delivers the email' do
      expect {
        post :create, message: @message
      }.to change {ActionMailer::Base.deliveries.size}.by(1)
    end

    describe 'delivered message' do
      before :each do
        post :create, message: @message
      end

      it "returns http success" do
        response.should be_redirect
      end

      it 'delivers the mail with the subject that we wanted to' do
        ActionMailer::Base.deliveries.last.subject.should == @message.subject
      end

      it 'delivers the mail with the body that we wanted to' do
        ActionMailer::Base.deliveries.last.body.to_s.should match @message.body
      end
    end
  end

  describe "POST 'create' for a diffusion" do
    it "returns http success" do
      @diffusion = Fabricate.build(:diffusion)
      expect {
        post 'create', message: @diffusion
      }.to change {ActionMailer::Base.deliveries.size}.by(@diffusion.email.size)
    end
  end
end
