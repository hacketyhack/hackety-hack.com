get '/hackers/:name' do
	@hacker = Hacker.first(:username => params[:name])
	haml :"hackers/show"
end
