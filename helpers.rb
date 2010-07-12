helpers do

	def current_user
		return User.first(:id => session[:user_id]) if session[:user_id]
		nil
	end

	def logged_in?
		return session[:user_id] != nil
	end

end
