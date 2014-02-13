require 'spec_helper'

describe UsersController do
	let(:bob){Fabricate(:user)}
	let(:mozart){Fabricate(:user)}

	describe('#index') do
		context "When user is no moderator" do
			it "try to get index" do
				get :index
				response.should redirect_to(root_path)
			end
		end

		context "When user is moderator" do
			before { sign_in Fabricate(:user, moderator: true) }
			it "gets index with authorization" do
				get :index
				response.should be_success
			end
		end
	end

	describe 'Following actions' do
		before { sign_in bob }
		it('#follow') do
			post :follow, user_id: bob, :user => {:followee => mozart.id}
			expect(flash[:notice]).to eq("You're following #{mozart.username} now")
		end
		it('#following?') do
			get :following, user_id: bob
  			response.should be_success
		end
		it ('#followers') do
			get :followers, user_id: bob
			response.should be_success
		end
	end
end
