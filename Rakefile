#this file sets up all of our rake tasks

require 'rubygems'
require 'spec/rake/spectask'
require 'cucumber/rake/task'

#this lets us run 'rake spec' to run rspec tests
Spec::Rake::SpecTask.new do |t|

	#tell rspec where our spec files are
	t.spec_files = FileList['spec/*_spec.rb',]
	
	#get some nice pretty options
	t.spec_opts = ["--colour", "--backtrace"]
	#
	#include our spec helper
	t.ruby_opts = ["-r spec/spec_helper.rb"]
end

#this lets us run 'rake features' to run cucumber tests
Cucumber::Rake::Task.new(:features) do |t|
	t.cucumber_opts = "--format progress"
end

#this namespace is used for all database related tasks
namespace :db do

	desc "Seed the database with initial data."
	task :seed do
		#connect to the database
		environment = ENV['RACK_ENV'] || "development"

		require 'mongo_mapper'
		MongoMapper.connection = Mongo::Connection.new('localhost')
		MongoMapper.database = "hackety-#{environment}"
		#make an admin user
		require 'models/hacker'
		admin = Hacker.create({
			:username => "admin",
			:email => "admin@example.com",
			:password => "password",
			:password_confirmation => "password",
			:admin => true
		})
	end
end
