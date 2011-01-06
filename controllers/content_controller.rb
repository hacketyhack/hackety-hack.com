# This is the controller that handles all of the different kinds of Content
# posted to the site.

get "/content/:id" do
  @content = Content.find(params[:id])
  haml :"content/show"
end

post "/content" do
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

post "/content/:id/comment" do
  @content = Content.first(:id => params[:id])
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

