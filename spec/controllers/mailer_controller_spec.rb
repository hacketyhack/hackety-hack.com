require 'spec_helper'

describe MailerController do
  let(:user) { Fabricate(:user) }

  describe "GET 'new' for a single user email" do
    it "returns http success" do
      get 'new', user: Array(user)
      response.should be_success
    end
  end

end
