# The **helpers.rb** file contains all of our Sinatra helpers. This is large
# enough that including it in a separate file makes it much easier to find;
# otherwise, I'd be opening **hackety.rb** and searching for 'helpers,' and
# that's just stupid.


helpers do

  # A tiny bit of metaprogramming goes a long way. We want to generate three
  # methods (`development?`, `production?`, and `test?`) that let us know which
  # environment we happen to be in. This is useful in a few places.
  [:development, :production, :test].each do |environment|
    define_method "#{environment.to_s}?" do
      return settings.environment == environment.to_sym
    end
  end

  # This incredibly useful helper gives us the currently logged in user. We
  # keep track of that by just setting a session variable with their id. If it
  # doesn't exist, we just want to return nil.
  def current_user
    return nil unless session[:hacker_id]

    # Memoize to make sure code like this works properly:
    # current_user.password = 'foo'
    # current_user.save
    @current_user ||= Hacker.first(:id => session[:hacker_id]) if session[:hacker_id]
  end

  # This very simple method checks if we've got a logged in user. That's pretty
  # easy: just check our current_user.
  def logged_in?
    current_user != nil
  end

  # Our `admin_only!` helper will only let admin users visit the page. If
  # they're not an admin, we redirect them to either / or the page that we
  # specified when we called it.
  def admin_only!(opts = {:return => "/"})
    unless logged_in? && current_user.admin?
      flash[:error] = "Sorry, buddy"
      redirect opts[:return]
    end
  end

  # Similar to `admin_only!`, `require_login!` only lets logged in users access
  # a particular page, and redirects them if they're not.
  def require_login!(opts = {:return => "/"})
    unless logged_in?
      flash[:error] = "Sorry, buddy"
      redirect opts[:return]
    end
  end

  # We also want to have a way for the desktop application to make calls to the
  # site. For this, we allow a username and password to be passed in, and we
  # authenticate directly, rather than relying on a previously logged in
  # session.
  def require_login_or_api!(opts={})
    return if session[:hacker_id]
    hacker = Hacker.authenticate(opts[:username], opts[:password])
    if hacker
      session[:hacker_id] = hacker.id
    else
      halt 401
    end
  end

  # [Gravatar](http://gravatar.com/) is used for our avatars. Generating the
  # url for one is pretty simple, we just need the proper email address, and
  # then we make an md5 of it. No biggie.
  def gravatar_url_for email
    require 'digest/md5'
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}"
  end

end

# This handy helper method lets us require an entire directory of `rb` files.
# It's much simpler than having to require them all directly.
def require_directory dirname
  Dir.glob("#{File.expand_path(File.dirname(__FILE__))}/#{dirname}/*.rb").each do |f|
    require f
  end
end

# This method is a handy monkeypatch on String. It allows us to turn any string
# into a slug that's suitable for putting into URLs.
class String
  def to_slug
    self.gsub(/[^a-zA-Z _0-9]/, "").gsub(/\s/, "_").downcase
  end
end

