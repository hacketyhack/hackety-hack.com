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
      get 'create', message: Fabricate.build(:message)
      response.should be_success
    end
  end

  describe "POST 'create' for a diffusion" do
    it "returns http success" do
      post 'create', message: Fabricate.build(:diffusion)
      response.should be_success
    end
  end
end
