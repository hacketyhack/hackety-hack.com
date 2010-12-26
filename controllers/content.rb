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

get "/content/:id" do
  @content = Content.find(params[:id])
  haml :"content/show"
end
