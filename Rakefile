require 'rubygems'
require 'spec/rake/spectask'
require 'cucumber/rake/task'

Spec::Rake::SpecTask.new do |t|
	t.spec_files = FileList['spec/*_spec.rb',]
	t.spec_opts = ["--colour", "--backtrace"]
end

Cucumber::Rake::Task.new(:features) do |t|
	t.cucumber_opts = "--format pretty"
end
