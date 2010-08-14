#This is the 'hackers' controller. "Hackers" are what we call "Users" in HH.


# An individual Hacker's page
get '/hackers/:name' do
	#find the hacker with the given name
	@hacker = Hacker.first(:username => params[:name])

	#render the template
	haml :"hackers/show"
end

#this lets you follow a Hacker
get '/hackers/:name/follow' do
	#we have to be logged in to follow someone
	require_login! :return => "/hackers/#{params[:name]}/follow"

	#find the hacker with the given name
	@hacker = Hacker.first(:username => params[:name])

	#follow them!
	Hacker.push_uniq(current_user.id, :following => @hacker.email)
	Hacker.push_uniq(@hacker.id, :followers => current_user.email)

	#set a message
	flash[:notice] = "Now following #{params[:name]}."

	#redirect back to your page!
	redirect "/hackers/#{current_user.username}"

end
