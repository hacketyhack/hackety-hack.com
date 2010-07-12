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
	#let's do some pretty output!
	t.cucumber_opts = "--format pretty"
end
