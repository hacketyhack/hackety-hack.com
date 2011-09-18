# This file sets up all of our rake tasks
require 'rubygems'
require 'bundler'
Bundler.setup

require 'rspec/core/rake_task'


desc "Generate documentation, and put it in the gh-pages branch"
task :dox do
  # First, we want to stash any changes. We only want stuff that's committed!
  sh "git stash"

  # Next, we need to run rocco.
  sh "rocco *.rb"
  sh "rocco controllers/*.rb"
  sh "rocco models/*.rb"

  # Then we want to stash the html we made, but first, we have to add it.
  sh "git add *.html"
  sh "git add controllers/*.html"
  sh "git add models/*.html"
  sh "git stash"

  # Next we switch to our documentation branch. We just want to overwrite the
  # old documenation with the new documentation, so in order for there to be no
  # conflicts, we need to kill all of the .html files, and then make
  # a temporary commit. Then we can pop our stash. If we didn't commit, it
  # wouldn't let us pop!
  sh "git checkout gh-pages"
  sh "find . -name '*.html' | xargs rm"
  sh "git commit -am 'temporary'"
  sh "git stash pop"

  # Now we add all of our new files, and then amend the temporary commit. We're
  # adding in both our new versions of files as well as a real commit message.
  sh "git add ."
  sh "git commit --amend -m 'Documentation generated #{Time.now}'"

  # Now that that's over, let's return to master, and pop our changes.
  sh "git checkout master"
  system "git stash pop"
end


desc 'Run the code in spec'
RSpec::Core::RakeTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.rspec_opts = "-r ./spec/spec_helper.rb"
end

namespace :spec do

  desc "Run the code examples in spec/acceptance"
  RSpec::Core::RakeTask.new(:acceptance) do |t|
    t.pattern = "spec/acceptance/**/*_spec.rb"
    t.rspec_opts = "-r spec/spec_helper.rb"
  end
end
