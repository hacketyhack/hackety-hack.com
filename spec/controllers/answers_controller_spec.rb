require 'spec_helper'

describe AnswersController do
	let(:newbie){Fabricate(:user)}
  let(:tricky){Fabricate(:question)}
  
  describe "#create" do

    before(:each) do
      sign_in newbie
      @valid_captcha_answer = { :description => "Foo", :captcha => "Bar", :captcha_key => "FooBar" }
      @invalid_captcha_answer = { :description => "Foo"}
    end

    context "post answer" do
      it "responds with success if captcha is correct" do
      	sign_in newbie
        post :create, :question_id => tricky, :answer => @valid_captcha_answer
        flash[:notice].should == "Answer Posted!"
      end

      it "responds with failure if captcha is incorrect" do
        post :create, :question_id => tricky, :answer => @invalid_captcha_answer
        flash[:notice].should == "Incorrect captcha, are you robot?"
      end
    end
  end
end