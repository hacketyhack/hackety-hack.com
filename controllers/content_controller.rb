# This is the controller that handles all of the different kinds of Content
# posted to the site.

# We need a simple GET action that displays the given Content.
get "/content/:id" do
  @content = Content.find(params[:id])
  haml :"content/show"
end

# We also need a simple POST that will create content.
post "/content" do
  require_login!

  params[:content][:author] = current_user.username
  params[:content][:author_email] = current_user.email
  @content = Content.create(params[:content])
  flash[:notice] = "Thanks for your post!"
  redirect "/stream"
end

# We're allowing comments to be made on posts, so we need a route for that as
# well.
post "/content/:id/comment" do
  require_login!
  @content = Content.first(:id => params[:id])

  params[:comment][:author] = current_user.username
  params[:comment][:author_email] = current_user.email
  @content.comments << Comment.new(params[:comment])
  @content.save

  flash[:notice] = "Replied!"
  redirect "/content/#{@content.id}"
end

