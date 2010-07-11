require 'rubygems'
require 'sinatra'
require 'spec'
require 'rack/test'
require 'factory_girl'
set :environment, :test

require 'hackety'

Dir.glob(File.join(File.dirname(__FILE__), '..', '/factories/*.rb')).each do |factory|
	require factory
end

describe "Hackety Website" do
	include Rack::Test::Methods
	def app; Sinatra::Application; end
	

	describe "routes" do
		it "should display all posts at /posts" do
			post1 = mock("Post", :title => "title", :body => "body", :comments => [])
			post2 = mock("Post", :title => "title", :body => "body", :comments => [])
			Post.should_receive(:all).and_return([post1,post2])
			get "/posts"
			last_response.status.should == 200
		end

		it "should display the edit page at /posts/:id/edit" do
			pending
			post = mock("Post", :title => "title", :body => "body", :id => 42)
			user = Factory(:admin)
			Post.should_receive(:find).with("42").and_return(post)
			get "/posts/#{post.id}/edit", {}, :session => {:user => user.id}
			last_response.status.should == 200
		end	
	end

	describe "comments" do
		describe "creating a new comment" do
			it "should create a new comment with valid attributes" do
				pending
				post = Factory(:post)
				user = Factory(:user)
				valid_attrs = {:post_id => post.id, :body => "this is a great post!"}
				comment = Factory(:comment, valid_attrs)
				Comment.should_recieve(:create).and_return(comment)
				post "/comments", valid_attrs
				last_response.status.should == 302
			end
		end
	end
end
