post "/content" do
  params[:content][:author] = current_user.username || "anonymous"
  params[:content][:author_email] = current_user.email || "anonymous@example.com"
  @content = Content.create(params[:content])
  flash[:notice] = "Thanks for your post!"
  redirect "/stream"
end

get "/content/:id" do
  @content = Content.find(params[:id])
  haml :"content/show"
end
