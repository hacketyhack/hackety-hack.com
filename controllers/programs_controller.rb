# We'd like to let people show their programs. The routes in this file let us
# do this.

# We're also going to let people write programs in the browser, just in case
# they'd like to share something, but the upload doesn't work, or they want to
# copy on part of their program, or anything else.
get "/programs/new" do
  require_login!
  haml :"programs/new"
end

# One of the best features of GitHub is the [Explore page](https://github.com/explore)
# . It shows off some neat repositories that people have made. So let's do
# that, as well. We want to show both the last 10 programs that have been
# updated, as well as some featured programs.
get "/programs" do
  @programs = Program.all.sort{|a, b| b.updated_at <=> a.updated_at }.first(10)
  haml :"programs/index"
end

# We need to let people upload programs, so here it is! We want to allow API
# access for this particular route, since we'll be uploading programs from the
# desktop application as well.
post "/programs" do
  require_login_or_api! :username => params[:username], :password => params[:password]

  # Forging who made the program would be bad!
  params[:program]['creator_username'] = current_user.username
  program = Program.create(params[:program])

  flash[:notice] = "Program created!"
  redirect "/programs/#{program.creator_username}/#{program.slug}"
end

# People should be able to comment on programs, and this route lets us do it.
post "/programs/:username/:slug/comment" do
  @program = Program.first(:creator_username => params[:username], :slug => params[:slug])

  # Good old anonymous comments need special care and attention.
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

# JSON is a really great way to share information that's intended to be
# consumed by someone else. This shows all of the programs a particular user
# has made.
get "/programs/:username.json" do
  programs = Program.all(:creator_username => params[:username])
  programs.to_json
end

# Each program that a user has created has its own page.
get "/programs/:username/:slug" do
  @program = Program.first(:creator_username => params[:username], :slug => params[:slug])
  haml :"programs/show"
end

# If your program is revised, you'll need to update it on the site too. We need
# this to be API accessable, so that the desktop program can do it too!
put "/programs/:username/:slug.json" do
  require_login_or_api! :username => params[:username], :password => params[:password]
  if current_user.username != params[:username]
    halt 401
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

