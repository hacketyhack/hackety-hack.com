require 'rubygems'
require 'spec/rake/spectask'
require 'cucumber/rake/task'

Spec::Rake::SpecTask.new do |t|
	t.spec_files = FileList['spec/*_spec.rb',]
	t.spec_opts = ["--colour", "--backtrace"]
	t.ruby_opts = ["-r spec/spec_helper.rb"]
end

Cucumber::Rake::Task.new(:features) do |t|
	t.cucumber_opts = "--format pretty"
end
