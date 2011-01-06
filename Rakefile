# The Rakefile only has one task. The description is pretty good.
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
  sh "git stash pop"
end
