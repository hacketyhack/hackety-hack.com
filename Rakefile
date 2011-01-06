# The Rakefile only has one task. The description is pretty good.
desc "Generate documentation, and put it in the gh-pages branch"
task :dox do
  # First, we want to stash any changes. We only want stuff that's committed!
  sh "git stash"

  # Next, we need to run rocco.
  sh "rocco *.rb"

  # Then we want to stash the html we made, but first, we have to add it.
  sh "git add *.html"
  sh "git stash"

  # Next we switch to our documentation branch, and then pop it.
  sh "git checkout gh-pages"
  sh "git stash pop"

  # Now we commit up!
  sh "git add ."
  sh "git commit -m 'Documentation generated #{Time.now}'"
  
  # Now that that's over, let's return to master, and pop our changes.
  sh "git checkout master"
  sh "git stash pop"
end
