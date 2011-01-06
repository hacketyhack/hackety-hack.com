# This is the controller that handles all of the different kinds of Content
# posted to the site.

# We need a simple GET action that displays the given Content.
get "/content/:id" do
  @content = Content.find(params[:id])
  haml :"content/show"
end

# We also need a simple POST that will create content.
post "/content" do

  # One small wrinkle: We're allowing anonymous posts. So, if we're not logged
  # in, we need to set the author and email properly so that all of our views
  # work.
  if current_user
    params[:content][:author] = current_user.username
    params[:content][:author_email] = current_user.email
  else
    params[:content][:author] = "anonymous"
    params[:content][:author_email] = "anonymous@example.com"
  end
  @content = Content.create(params[:content])
  flash[:notice] = "Thanks for your post!"
  redirect "/stream"
end

# We're allowing comments to be made on posts, so we need a route for that as
# well.
post "/content/:id/comment" do
  @content = Content.first(:id => params[:id])

  # We have the same wrinkle as we do when making posts: We're allowing
  # anonymous comments. So we have to properly set all that up.
  if current_user
    params[:comment][:author] = current_user.username
    params[:comment][:author_email] = current_user.email
  else 
    params[:comment][:author] = "Anonymous"
    params[:comment][:author_email] = "anonymous@example.com"
  end
  @content.comments << Comment.new(params[:comment])
  @content.save

  flash[:notice] = "Replied!"
  redirect "/content/#{@content.id}"
end

