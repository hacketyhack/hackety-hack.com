helpers do

	def current_user
		return Hacker.first(:id => session[:hacker_id]) if session[:hacker_id]
		nil
	end

	def logged_in?
		return session[:hacker_id] != nil
	end

end
