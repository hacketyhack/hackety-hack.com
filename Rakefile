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
		MongoMapper.database.collections.each do |c| 
			c.remove
		end 


		#make an admin user
		require 'models/hacker'
		admin = Hacker.create({
			:username => "admin",
			:email => "admin@example.com",
			:password => "password",
			:password_confirmation => "password",
			:admin => true
		})

		#we're also going to make a regular user too
		somebody = Hacker.create({
			:username => "somebody",
			:email => "somebody@example.com",
			:password => "password",
			:password_confirmation => "password",
		})
		#make an initial Post, with a comment
		require 'models/post'
		require 'models/comment'
		post = Post.create({
			:title => "Welcome to the Hackety Site!",
			:body => "This is an intial post, so that you can see how everything looks. Here's a [link](http://github.com/hacketyhack/hackety-hack.com) to the source code on GitHub. Now I'm just going to do the usual stuff:
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

And a blockquote:

> Lorem ipsum dolor sit amet, consectetur adipiscicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

Esse insolens mnesarchum eam id, nec ad detracto disputando. Nec malorum postulant disputationi ad. Pri menandri inimicus ut. Pro velit affert mediocritatem at, eu nec voluptua inciderint, ne mei diam praesent. No eum tamquam appetere, ex eos habemus evertitur consequat, quo et wisi tincidunt consectetuer. Vocent lobortis est cu."			
		})

		post.comments << Comment.new({
			:body => "This post is awesome! I've never seen such insightful commentary!",
			:author => "somebody",
			:author_email => "somebody@example.com"
		})
		post.comments << Comment.new({
			:body => "Oh, and I almost forgot! I wanted to say something really long, so that we could see how a long comment looks, but I was in such a hurry to compliment your excellent writing that I could barely contain myself! Luckily, this time I'm much more verbose, and so it should fulfill the objective. Great!",
			:author => "somebody",
			:author_email => "somebody@example.com"
		})
		post.save

		#now let's make a discussion on the forum:
		require 'models/discussion'
		require 'models/reply'
		require 'utility'
		halp = Discussion.create({
			:title => "HALP ME!",
			:body => "I just don't understand!",
			:forum => "learning_ruby",
			:author => "somebody"
		})

		#and a reply:
		halp.replies << Reply.new({
			:body => "I'd love to help you!",
			:author => "admin"
		})

		halp.save
	end
end
