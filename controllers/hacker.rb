#This is the 'hackers' controller. "Hackers" are what we call "Users" in HH.


# An individual Hacker's page
get '/hackers/:name' do
	#find the hacker with the given name
	@hacker = Hacker.first(:username => params[:name])

	#render the template
	haml :"hackers/show"
end
