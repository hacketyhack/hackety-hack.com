#This is the 'hackers' controller. "Hackers" are what we call "Users" in HH.


# An individual Hacker's page
get '/hackers/:name' do
  #find the hacker with the given name
  @hacker = Hacker.first(:username => params[:name])

  #render the template
  haml :"hackers/show"
end

#update a hacker's information
post '/hackers/update' do
  #you have to be logged in to update your info
  require_login! :return => "/hackers/update"

  #do they want to update their password
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

#this lets you follow a Hacker
get '/hackers/:name/follow' do
  #we have to be logged in to follow someone
  require_login! :return => "/hackers/#{params[:name]}/follow"

  #find the hacker with the given name
  @hacker = Hacker.first(:username => params[:name])

  #make sure we're not following them already
  if current_user.following? @hacker
    flash[:notice] = "You're already following #{params[:name]}."
    redirect "/hackers/#{current_user.username}"
    return
  end

  #follow them!
  current_user.follow! @hacker

  #set a message
  flash[:notice] = "Now following #{params[:name]}."

  #redirect back to your page!
  redirect "/hackers/#{current_user.username}"

end

#this lets you unfollow a Hacker
get '/hackers/:name/unfollow' do
  #we have to be logged in to unfollow someone
  require_login! :return => "/hackers/#{params[:name]}/unfollow"

  #find the hacker with the given name
  @hacker = Hacker.first(:username => params[:name])
  
  #make sure we're not following them already
  unless current_user.following? @hacker
    flash[:notice] = "You're already not following #{params[:name]}."
    redirect "/hackers/#{current_user.username}"
    return
  end

  #unfollow them!
  current_user.unfollow! @hacker

  #set a message
  flash[:notice] = "No longer following #{params[:name]}."

  #redirect back to your page!
  redirect "/hackers/#{current_user.username}"

end

#this lets us see followers
get '/hackers/:name/followers' do
  #find the hacker with the given name
  @hacker = Hacker.first(:username => params[:name])

  #render our page
  haml :"hackers/followers"
end

#this lets us see following
get '/hackers/:name/following' do
  #find the hacker with the given name
  @hacker = Hacker.first(:username => params[:name])

  #render our page
  haml :"hackers/following"
end
