get "/programs/new" do
	require_login!
	haml :"programs/new"
end

post "/programs" do
	require_login_or_api! :username => params[:username], :password => params[:password] 
	params[:program]['creator_username'] = current_user.username
	program = Program.create(params[:program])
	flash[:notice] = "Program created!"
	redirect "/programs/#{program.creator_username}/#{program.slug}"
end

get "/programs/:username/:slug" do
	@program = Program.first(:creator_username => params[:username], :slug => params[:slug])
	haml :"programs/show"
end
