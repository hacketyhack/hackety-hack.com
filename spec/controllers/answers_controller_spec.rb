require 'spec_helper'

describe AnswersController do
	let(:newbie){Fabricate(:user)}
  let(:tricky){Fabricate(:question)}
  let(:genius){Fabricate(:answer)}
  
  describe "#create" do
    context "captcha" do
      it "responds with success" do
      	sign_in newbie
        post :create, :question_id => tricky, :answer => genius
        puts params
        response.should be_success
      end
    end
  end
end