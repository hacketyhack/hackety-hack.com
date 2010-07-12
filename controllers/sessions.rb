get '/signup' do
	haml :"sessions/signup"
end

post '/signup' do
	@hacker = Hacker.create(params[:user])
	if @hacker && @hacker.valid?
		session[:user] = @user.id
		flash[:notice] = "Account created."
		redirect '/'
	else
		flash[:notice] = 'There were some problems creating your account. Please be sure you\'ve entered all your information correctly.'
		redirect '/signup'
	end
end

get '/login' do
	haml :"sessions/login"
end

post '/login' do
	if hacker = Hacker.authenticate(params[:username], params[:password])
		session[:hacker_id] = hacker.id
		flash[:notice] = "Login successful."

		if session[:return_to]
			redirect_url = session[:return_to]
			session[:return_to] = false
			redirect redirect_url
		else
			redirect '/'
		end
	else
		flash[:notice] = "The username or password you entered is incorrect."
		redirect '/login'
	end
end

get '/logout' do
	session[:hacker_id] = nil
	flash[:notice] = "Logout successful."
	redirect '/'
end
