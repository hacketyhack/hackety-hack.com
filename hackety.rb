require 'rubygems'
require 'sinatra'
require 'mongo_mapper'
require 'haml'
require 'rack-flash'
require 'rdiscount'

use Rack::Session::Cookie, :secret => 'h4ck3ty h4ck f0r gr347 g00d'
use Rack::Flash

set :views, File.join(File.dirname(__FILE__), 'views')

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

helpers do

	def current_user
		return User.first(:id => session[:user_id]) if session[:user_id]
		nil
	end

	def logged_in?
		return session[:user_id] != nil
	end

end

get "/" do
	haml :index
end

get "/blog" do
	@posts = Post.all
	haml :'posts/index'
end

get "/posts/new" do
	unless logged_in? && current_user.admin?
		flash[:error] = "Sorry, buddy"
		redirect "/posts"
	end

	haml :'posts/new'
end

post "/posts" do
	unless logged_in? && current_user.admin?
		flash[:error] = "Sorry, buddy"
		redirect "/posts"
	end

	@post = Post.create(params)
	flash[:notice] = "Post Created"
	redirect "/posts/#{@post.id}" 
end

get "/posts" do
	@posts = Post.all
	haml :'posts/index'
end

get "/posts/:id" do
	@post = Post.find(params[:id])
	haml :'posts/show'
end

get "/posts/:id/edit" do
	unless logged_in? && current_user.admin?
		flash[:error] = "Sorry, buddy"
		redirect "/posts"
	end

	@post = Post.find(params[:id])
	haml :'posts/edit'
end

put "/posts/:id" do
	unless logged_in? && current_user.admin?
		flash[:error] = "Sorry, buddy"
		redirect "/posts"
	end
	@post = Post.find(params[:id])
	@post.update_attributes(params)
	flash[:notice] = "Post Modified"
	redirect "/posts/#{@post.id}"
end

post "/comments" do
	unless current_user
		flash[:error] = "You must be logged in to comment!"
		redirect "/posts"
	end

	params[:comment]['user_email'] = current_user.email
	@post = Post.find(params[:post_id])
	@post.comments << Comment.new(params[:comment])
	@post.save
	flash[:notice] = "Thanks for your comment!"
	redirect "/posts/#{@post.id}" 
end

get '/signup' do
	haml :"users/signup"
end

post '/signup' do
	@user = User.create(params[:user])
	if @user && @user.valid?
		session[:user] = @user.id
		flash[:notice] = "Account created."
		redirect '/'
	else
		flash[:notice] = 'There were some problems creating your account. Please be sure you\'ve entered all your information correctly.'
		redirect '/signup'
	end
end

get '/login' do
	haml :"users/login"
end

post '/login' do
	if user = User.authenticate(params[:username], params[:password])
		session[:user_id] = user.id
		flash[:notice] = "Login successful."

		if session[:return_to]
			redirect_url = session[:return_to]
			session[:return_to] = false
			redirect redirect_url
		else
			redirect '/'
		end
	else
		flash[:notice] = "The username or password you entered is incorrect."
		redirect '/login'
	end
end

get '/logout' do
	session[:user_id] = nil
	flash[:notice] = "Logout successful."
	redirect '/'
end

