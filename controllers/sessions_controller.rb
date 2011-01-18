#The session controller deals with users loggin in, logging out, and
#signing up. An important part of the site!

# New users sign up at /signup
get '/signup' do
  haml :"sessions/signup", :layout => :plain
end

# The form for /signup sends a POST to /signup!
post '/signup' do
  @hacker = Hacker.create(params[:user])

  if @hacker && @hacker.valid?
    #let's log them in, too.
    session[:hacker_id] = @hacker.id

    flash[:notice] = "Account created."
    redirect '/'
  else

    flash[:notice] = 'There were some problems creating your account. Please be sure you\'ve entered all your information correctly.'

    redirect '/download'
  end
end

# People can log in by going to /login
get '/login' do
  haml :"sessions/login", :layout => :plain
end

# The form at /login sends a POST request to /login
post '/login' do
  #let's see if we got a correct username/password:
  if hacker = Hacker.authenticate(params[:username], params[:password])

    session[:hacker_id] = hacker.id

    flash[:notice] = "Login successful."

    if session[:return_to]
      # Let's return back to where we were before.
      redirect_url = session[:return_to]
      session[:return_to] = false
      redirect redirect_url
    else
      # If we didn't go somewhere special, let's just go to the stream
      redirect '/stream'
    end
  else
    flash[:notice] = "The username or password you entered is incorrect."
    redirect '/login'
  end
end

# Users can logout by going to /logout
get '/logout' do
  #we need to remove our id from the session
  session[:hacker_id] = nil

  flash[:notice] = "Logout successful."
  redirect '/'
end

# This method allows people to check their credentials. This is primarily used
# by the desktop app to see if you've entered correct information.
post '/check_credentials' do
  #let's see if we got a correct username/password:
  puts "username: #{params[:username]} / #{params[:password]}"
  if Hacker.authenticate(params[:username], params[:password])
    "Success"
  else
    halt 401
  end
end
