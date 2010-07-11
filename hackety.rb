require 'rubygems'
require 'sinatra'
require 'mongo_mapper'
require 'sinatra-authentication'
require 'haml'
require 'rack-flash'
require 'rdiscount'

use Rack::Session::Cookie, :secret => 'h4ck3ty h4ck f0r gr347 g00d'
use Rack::Flash

set :views, File.join(File.dirname(__FILE__), 'views')
set :sinatra_authentication_view_path, Pathname(__FILE__).dirname.expand_path + "views/auth/"


def setup_db environ
	MongoMapper.connection = Mongo::Connection.new('localhost')
	MongoMapper.database = "hackety-#{environ}"
end

configure :test do
	setup_db(:test)
end

configure :development do
	setup_db(:development)
end

configure do
	Dir.glob("#{File.expand_path(File.dirname(__FILE__))}/models/*.rb").each do |f|
		require f
	end
end

get "/" do
	haml :index
end

get "/blog" do
	@posts = Post.all
	haml :blog_index
end

get "/posts/new" do
	unless current_user.admin?
		flash[:notice] = "Sorry, buddy"
		redirect "/posts"
	end

	haml :posts_new
end

post "/posts" do
	unless current_user.admin?
		flash[:notice] = "Sorry, buddy"
		redirect "/posts"
	end

	@post = Post.create(params)
	flash[:notice] = "Post Created"
	redirect "/posts/#{@post.id}" 
end

get "/posts" do
	@posts = Post.all
	haml :posts_index
end

get "/posts/:id" do
	@post = Post.find(params[:id])
	haml :posts_show
end

get "/posts/:id/edit" do
	unless current_user.admin?
		flash[:notice] = "Sorry, buddy"
		u = User.get({:permission_level => -1})
		flash[:notice] << u.id.to_s + " " + current_user.id.to_s
		#redirect "/posts"
	end

	@post = Post.find(params[:id])
	haml :posts_edit
end

put "/posts/:id" do
	@post = Post.find(params[:id])
	@post.update_attributes(params)
	flash[:notice] = "Post Modified"
	redirect "/posts/#{@post.id}"
end

post "/comments" do
	unless current_user
		flash[:notice] = "You must be logged in to comment!"
		redirect "/posts"
	end

	params[:comment]['user_email'] = current_user.email
	@post = Post.find(params[:post_id])
	@post.comments << Comment.new(params[:comment])
	@post.save
	flash[:notice] = "Thanks for your comment!"
	redirect "/posts/#{@post.id}" 
end

