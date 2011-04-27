#This is the 'hackers' controller. "Hackers" are what we call "Users" in HH.

# We want to give our Hackers a profile page.
get '/hackers/:name' do
  @hacker = Hacker.first(:username => params[:name])
# Fix "Application Error" when visiting a users profile page
  haml :"hackers/show"
end

# People need to be able to update their information. Of course, this means
# that they need to be logged in.
post '/hackers/update' do
  require_login! :return => "/hackers/update"

  # If they're trying to update their password, let's take care of that. If we
  # don't, then we wouldn't want to set their password to nil! That'd be bad.
  unless params[:password].nil?
    if params[:password][:new] == params[:password][:confirm]
      current_user.password = params[:password][:new]
      current_user.save
      flash[:notice] = "Password updated!"
    else
      flash[:notice] = "Password confirmation didn't match!"
    end
  else
    current_user.update_attributes(:about => params[:hacker][:about])
    current_user.save
    flash[:notice] = "About information updated!"
  end

  redirect "/hackers/#{current_user.username}"

end

# Hackers can follow each other, and this route takes care of it!
get '/hackers/:name/follow' do
  require_login! :return => "/hackers/#{params[:name]}/follow"

  @hacker = Hacker.first(:username => params[:name])

  #make sure we're not following them already
  if current_user.following? @hacker
    flash[:notice] = "You're already following #{params[:name]}."
    redirect "/hackers/#{current_user.username}"
    return
  end

  # then follow them!
  current_user.follow! @hacker

  flash[:notice] = "Now following #{params[:name]}."
  redirect "/hackers/#{current_user.username}"
end

#this lets you unfollow a Hacker
get '/hackers/:name/unfollow' do
  require_login! :return => "/hackers/#{params[:name]}/unfollow"

  @hacker = Hacker.first(:username => params[:name])

  #make sure we're following them already
  unless current_user.following? @hacker
    flash[:notice] = "You're already not following #{params[:name]}."
    redirect "/hackers/#{current_user.username}"
    return
  end

  #unfollow them!
  current_user.unfollow! @hacker

  flash[:notice] = "No longer following #{params[:name]}."
  redirect "/hackers/#{current_user.username}"
end

# this lets us see followers.
get '/hackers/:name/followers' do
  @hacker = Hacker.first(:username => params[:name])

  haml :"hackers/followers"
end

# This lets us see who is following.
get '/hackers/:name/following' do
  @hacker = Hacker.first(:username => params[:name])

  haml :"hackers/following"
end

