#this file sets up all of our rake tasks

require 'rubygems'
require 'bundler'
Bundler.setup

require 'rspec/core/rake_task'

desc 'Run the code in spec'
RSpec::Core::RakeTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
end

namespace :spec do

  desc "Run the code examples in spec/acceptance"
  RSpec::Core::RakeTask.new(:acceptance) do |t|
    t.pattern = "spec/acceptance/**/*_spec.rb"
  end

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
      :username => "steve",
      :email => "steve@steveklabnik.com",
      :password => "password",
      :password_confirmation => "password",
      :admin => true,
      :about => "I hack on Hackety Hack!"
    })

    #we're also going to make a regular user too
    somebody = Hacker.create({
      :username => "somebody",
      :email => "somebody@example.com",
      :password => "password",
      :password_confirmation => "password",
      :about => "I'm just a regular person!"
    })

    #now let's make a discussion on the forum:
    require 'models/discussion'
    require 'models/reply'
    require 'utility'
    halp = Discussion.create({
      :title => "HALP ME!",
      :body => "I just don't understand!",
      :forum => "learning_ruby",
      :author => "somebody",
      :author_email => "somebody@example.com"
    })

    #and a reply:
    halp.replies << Reply.new({
      :body => "I'd love to help you!",
      :author => "steve",
      :author_email => "steve@steveklabnik.com"
    })

    halp.save
  end
end

namespace :whitespace do
  desc 'Removes trailing whitespace'
  task :cleanup do
    sh %{find . -name '*.rb' -exec sed -i '' 's/ *$//g' {} \\;}
  end
  task :retab do
    sh %{find . -name '*.rb' -exec sed -i '' 's/\t/  /g' {} \\;}
    sh %{find . -name '*.feature' -exec sed -i '' 's/\t/  /g' {} \\;}
  end
end

