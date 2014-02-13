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
end
