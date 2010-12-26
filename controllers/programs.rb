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

post "/programs/:username/:slug/comment" do
  @program = Program.first(:creator_username => params[:username], :slug => params[:slug])
  if current_user
    params[:comment][:author] = current_user.username
    params[:comment][:author_email] = current_user.email
  else 
    params[:comment][:author] = "Anonymous"
    params[:comment][:author_email] = "anonymous@example.com"
  end
  @program.comments << Comment.new(params[:comment])
  @program.save

  flash[:notice] = "Replied!"
  redirect "/programs/#{params[:username]}/#{params[:slug]}"
end

get "/programs/:username.json" do
  programs = Program.all(:creator_username => params[:username])
  programs.to_json
end

get "/programs/:username/:slug" do
  @program = Program.first(:creator_username => params[:username], :slug => params[:slug])
  haml :"programs/show"
end

put "/programs/:username/:slug.json" do
  require_login_or_api! :username => params[:username], :password => params[:password]
  if current_user.username != params[:username]
    redirect "/"
  end
  program = Program.first(:creator_username => params[:username], :slug => params[:slug])
  if program.nil?
    program = Program.create(params)
  else
    program.update_attributes(params)
    program.save
  end

  flash[:notice] = "Program updated!"
  redirect "/programs/#{program.creator_username}/#{program.slug}"
end

put "/programs/:username/:slug" do
  require_login_or_api! :username => params[:username], :password => params[:password]
  if current_user.username != params[:username]
    flash[:notice] = "Sorry, buddy"
    redirect "/"
  end
  program = Program.first(:creator_username => params[:username], :slug => params[:slug])
  program.update_attributes(params[:program])
  program.save

  flash[:notice] = "Program updated!"
  redirect "/programs/#{program.creator_username}/#{program.slug}"
end

