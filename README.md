# hackety-hack.com #

[![Build status](https://secure.travis-ci.org/hacketyhack/hackety-hack.com.png)](http://travis-ci.org/#!/hacketyhack/hackety-hack.com)[![Code Climate](https://codeclimate.com/github/hacketyhack/hackety-hack.com.png)](https://codeclimate.com/github/hacketyhack/hackety-hack.com)[![Coverage Status](https://coveralls.io/repos/hacketyhack/hackety-hack.com/badge.png?branch=master)](https://coveralls.io/r/hacketyhack/hackety-hack.com?branch=master)

[hackety-hack.com][hh.com] is the web backend powering the collaborative features of [Hackety Hack][hh]. It is written in Rails 3 and continues to be under active development (see 'Helping Out'), the switch to Rails 3 happened quite recently so there's still lots to be done.

### Helping Out ###

If you have any experience writing Rails apps, feel free to help out, we're open to pull requests as long as you follow a few conditions.

+ **Test your code**, we really can't stress this enough, ideally you should be practicing [TDD][tdd] and writing tests before you even write your code. If you don't test your code, we have no way of knowing if it works properly so please do test.
+ **If it's a major feature, file an issue**, if you file an issue we can discuss certain aspects of the new feature with you and ensure it's a good fit for hackety-hack.com.

## Translations ##

Hello everyone!

We are in the process of translating Hackety Hack into as many foreign languages as possible so that people around the world would be able to use the site with ease. If you are bilingual and interested in helping us make Hackety Hack a truly global phenomenon, accessible by all regardless of location or nationality, and make learning Ruby even more fun! then please sign up here http://crowdin.net/project/hackety-hackcom/invite

## Getting Started ##

Once you've cloned this repository, running `script/bootstrap` should tell you everything you need to know.

In case you prefer gems to be managed entirely by bundler run this before bootstrapping:

    bundle config --global path .bundle
    bundle config --global binstubs bin
    export PATH="$PWD/bin:$PATH"

Be careful with using `bin` in `$PATH` it is very risky when used with public projects.

Dependencies for the curious:

- Ruby: 1.9.3 is preferred.
- MongoDB: 2.2.x or 2.4.x

As long as you have those things, the script will handle the rest as best it can, including installing the gem dependencies with Bundler.

If the tests aren't passing when you clone, open [an issue][issues] or drop into
[#hacketyhack on freenode][irc].

Additionally, if you're _not_ a developer and you have a feature you'd really like to see on the site, file [an issue][issues] and we'll be sure to look into it on your behalf.

[hh.com]: http://hackety-hack.com/
[hh]:     https://github.com/hacketyhack/hacketyhack
[irc]: http://webchat.freenode.net/?channels=#hacketyhack
[issues]: https://github.com/hacketyhack/hackety-hack.com/issues
[tdd]:    http://en.wikipedia.org/wiki/Test-driven_development
