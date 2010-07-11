require 'rubygems'
require 'sinatra'
require 'spec'
require 'rack/test'
set :environment, :test

require 'hackety'

describe "Hackety Website" do
	include Rack::Test::Methods
	def app; Sinatra::Application; end

	describe "routes" do
		it "should display all posts at /posts" do
			post1 = mock("Post", :title => "title", :body => "body")
			post2 = mock("post", :title => "title", :body => "body")
			Post.should_receive(:all).and_return([post1,post2])
			get "/posts"
			last_response.status.should == 200
		end
	end
end
