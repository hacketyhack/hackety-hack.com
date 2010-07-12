get '/hackers/:name' do
	@hacker = User.first(:username => params[:name])
	haml :"hackers/show"
end
