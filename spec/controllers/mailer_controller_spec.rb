require 'spec_helper'

describe MailerController do
  let(:user) { Fabricate(:user) }
  let(:users) { Fabricate.sequence(:user, 5)}
  let(:diffusion) { Fabricate.build(:diffusion) }

  shared_examples 'unauthorized' do
    it 'redirects to the login page' do
      response.should redirect_to(login_path)
    end
  end

  describe "GET 'new' for a single user email" do

    context 'when user is a moderator' do
      before { sign_in Fabricate(:user, moderator: true) }
      it "returns http success" do
        get :new, user: Array(user)
        response.should be_success
      end
    end

    context 'when user is not a moderator' do
      before do
        sign_in Fabricate(:user)
        get :new, user: Array(user)
      end
      it_behaves_like 'unauthorized'
    end

    context 'when user is a guest' do
      before { get :new, user: Array(user) }
      it_behaves_like 'unauthorized'
    end
  end

  describe "GET 'new' for a diffusion" do
    context 'when user is a moderator' do
      before { sign_in Fabricate(:user, moderator: true) }
      it "returns http success" do
        get :new, user: Array(users)
        response.should be_success
      end
    end

    context 'when user is not a moderator' do
      before do
        sign_in Fabricate(:user)
        get :new, user: Array(users)
      end
      it_behaves_like 'unauthorized'
    end

    context 'when user is a guest' do
      before { get :new, user: Array(users) }
      it_behaves_like 'unauthorized'
    end
  end

  describe "POST 'create' for a single user email" do
    before :each do
      @message = Fabricate.build(:message)
    end

    context 'when user is a moderator' do
      before { sign_in Fabricate(:user, moderator: true) }
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

    context 'when user is not a moderator' do
      before do
        sign_in Fabricate(:user)
        post :create, message: @message
      end
      it_behaves_like 'unauthorized'
    end

    context 'when user is a guest' do
      before { post :create, message: @message }
      it_behaves_like 'unauthorized'
    end
  end

  describe "POST 'create' for a diffusion" do
    context 'when user is a moderator' do
      before { sign_in Fabricate(:user, moderator: true) }
      it "returns http success" do
        expect {
          post 'create', message: diffusion
        }.to change {ActionMailer::Base.deliveries.size}.by(diffusion.email.size)
      end
    end

    context 'when user is not a moderator' do
      before do
        sign_in Fabricate(:user)
        post :create, message: diffusion
      end
      it_behaves_like 'unauthorized'
    end

    context 'when user is a guest' do
      before { post :create, message: diffusion }
      it_behaves_like 'unauthorized'
    end
  end
end
