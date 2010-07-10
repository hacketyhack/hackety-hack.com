require 'rubygems'
require 'sinatra'
require 'mongo_mapper'

configure do
	MongoMapper.connection = Mongo::Connection.new('localhost')
	MongoMapper.database = 'hackety'
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
