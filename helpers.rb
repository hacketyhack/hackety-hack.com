#this helpers file contains lots of helpful little methods
#to make our work with sinatra easier

helpers do

  #this defines three helpers, that all test our environment:
  #they're called 'development?', 'test?', and 'production?'
  [:development, :production, :test].each do |environment|
    define_method "#{environment.to_s}?" do
      return settings.environment == environment.to_sym
    end
  end

  #this method returns the logged_in hacker
  def current_user
    #let's look up the Hacker by the id in the session
    return Hacker.first(:id => session[:hacker_id]) if session[:hacker_id]

    #if we can't find them, just return nil
    nil
  end

  #this method returns true if we're logged in, and false if we're not
  def logged_in?
    #pretty easy, just check the session
    return session[:hacker_id] != nil
  end

  #this helper checks if the current_user is admin, and redirects them if they're not
  def admin_only!(opts = {:return => "/"})
    #we need to be both logged_in and an admin for this to work
    unless logged_in? && current_user.admin?
      #if we're not, set an error message
      flash[:error] = "Sorry, buddy"

      #and get redirected
      redirect opts[:return]
    end
  end

  #this method makes sure that we're logged in
  def require_login!(opts = {:return => "/"})
    #if we're not
    unless logged_in?
      #set an error message
      flash[:error] = "Sorry, buddy"

      #and get redirected
      redirect opts[:return]
    end
  end

  #this method lets us use an api call as well as logging in
  def require_login_or_api!(opts = {:return => "/"})
    hacker = Hacker.authenticate(opts[:username], opts[:password])
    if hacker
      session[:hacker_id] = hacker.id
    else
      require_login!(opts)
    end
  end

  #gives a gravatar url for an email
  def gravatar_url_for email
    require 'md5'
    "http://www.gravatar.com/avatar/#{MD5::md5(email.downcase)}"
  end

  #gives a printable forum name from a slug
  def forum_name forum
    case forum
    when 'learning_ruby'
      "Learning Ruby"
    when 'hackety_help'
      "Hackety Help"
    when 'clubhouse'
      "The Clubhouse"
    end
  end

  #gives a description for a forum
  def forum_description forum
    case forum
    when 'learning_ruby'
        "A place to learn about the Ruby programming language."
    when 'hackety_help'
        "Have a question about Hackety? You're in the right place!"
    when 'clubhouse'
        "A place to talk to other Hackers about anything you'd like to talk about."
    end
  end
end
