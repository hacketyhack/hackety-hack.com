#The session controller deals with users loggin in, logging out, and
#signing up. An important part of the site!

#new users sign up at /signup
get '/signup' do

	#just render our template!
	haml :"sessions/signup"
end

#the form for /signup sends a POST to /signup!
post '/signup' do
	#create a new hacker with our parameters
	@hacker = Hacker.create(params[:user])

	#we need to make sure all the information is okay.
	if @hacker && @hacker.valid?
		#add our hacker_id to the session
		session[:hacker_id] = @hacker.id

		#set a friendly message
		flash[:notice] = "Account created."

		#let's go to the main page!
		redirect '/'
	else
		#this is what happens if the information is bad.
		
		#set an error message
		flash[:notice] = 'There were some problems creating your account. Please be sure you\'ve entered all your information correctly.'

		#let's go back to the signup page so that they can try again.
		redirect '/signup'
	end
end

#people can log in by going to /login
get '/login' do
	#just gotta render that template!
	haml :"sessions/login"
end

#the form at /login sends a POST request to /login
post '/login' do
	#let's see if we got a correct username/password:
	if hacker = Hacker.authenticate(params[:username], params[:password])

		#we did! Set our session up
		session[:hacker_id] = hacker.id

		#let the user know they logged in via a flash message
		flash[:notice] = "Login successful."

		#if they came from somewhere special, let's take them back there!
		if session[:return_to]
			#grab the url we need to go to
			redirect_url = session[:return_to]

			#reset the session so we don't go there twice
			session[:return_to] = false

			#go to the url!
			redirect redirect_url
		else
			#if we didn't go somewhere special, let's just go to /
			redirect '/'
		end
	else
		#oops! I guess we got our information wrong! Let's give them a message:
		flash[:notice] = "The username or password you entered is incorrect."

		#and go back to the login page so they can try again
		redirect '/login'
	end
end

#users can logout by going to /logout
get '/logout' do
	#we need to remove our id from the session
	session[:hacker_id] = nil

	#and let the user know they logged out!
	flash[:notice] = "Logout successful."

	#and then return to the main page
	redirect '/'
end
