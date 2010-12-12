# hackety-hack.com

Check it out! This is the source code for hackety-hack.com, which is the site for Hackety Hack! You can check it out at... http://hackety-hack.com !

## Requirements

So you'd like to hack on the site, eh? No problem. It's built on a few things:

* [Ruby](http://ruby-lang.org/) - Ruby is a great programming language.
* [Sinatra](http://sinatrarb.com/) - Sinatra is a classy web framework in Ruby.
* [Bundler](http://gembundler.com/) - Bundler manages gem dependencies. 
* [MongoDB](http://mongodb.com) - MongoDB is a sweet database.
* [Git](http://git-scm.com/) - git is a Distributed Version Control System. 

This is all you need to get started!

### Git

To install git, check out the [download page](http://git-scm.com/download) on the git site.
Once you have `git` installed, you can clone the repository:

`git clone http://github.com/hacketyhack/hackety-hack.com.git`

This will make a 'hackety-hack.com' directory in the current directory.

### Ruby

You probably already have Ruby 1.8.7 installed on your computer. If not, see [the download page](http://www.ruby-lang.org/en/downloads/).

If you use `rvm` with Ruby, you should create a gemset:

    $ rvm use 1.8.7
    $ rvm gemset create hackety-hack.com
    $ rvm use 1.8.7@hackety-hack.com

There is an .rvmrc file to facilitate switching into the correct Ruby when you cd into the project directory.

### Bundler

Bundler is a Ruby gem, so you can use the `gem` program to install it:

`gem install bundler`

### Sinatra

Since Sinatra is also a gem, you can install it (and all the other dependancies) with `bundle`:

`cd hackety-hack.com`
`bundle install`

### MongoDB

You can find instructions for installing MongoDB [on their website](http://www.mongodb.org/downloads).

## Running the site

Once you've got everything installed, make sure that you have the MongoDB server running. You'll probably use the `mongod` command to do this. I do this:

`mongod`

Next, use `rackup` to start a web server: 

`rackup config.ru`

And you should have everything going on localhost, at port 9292. Open your browser to 'http://localhost:9292' and check it out!

## Tests

We use both RSpec and Steak for testing. You can run this command to run all of the tests:

`rake spec`

We're aiming for as large of test coverage as possible, though not quite 100%. More tests are always better!

## Bug reports

We use [GitHub Issues](http://github.com/hacketyhack/hackety-hack.com/issues) to keep track of bugs and the features that we'd like to have. If you're looking for something to do, you can try checking there!
