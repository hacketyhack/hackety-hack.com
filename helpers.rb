#this helpers file contains lots of helpful little methods
#to make our work with sinatra easier

helpers do

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

end
