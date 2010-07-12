get '/signup' do
	haml :"users/signup"
end

post '/signup' do
	@user = User.create(params[:user])
	if @user && @user.valid?
		session[:user] = @user.id
		flash[:notice] = "Account created."
		redirect '/'
	else
		flash[:notice] = 'There were some problems creating your account. Please be sure you\'ve entered all your information correctly.'
		redirect '/signup'
	end
end

get '/login' do
	haml :"users/login"
end

post '/login' do
	if user = User.authenticate(params[:username], params[:password])
		session[:user_id] = user.id
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
	session[:user_id] = nil
	flash[:notice] = "Logout successful."
	redirect '/'
end
