# This is the new message form.
get "/messages/new/to/:username" do
  require_login!

  @username = params[:username]
  haml :"messages/new"
end

# This route actually creates the messages.
post "/messages" do
  require_login!

  # We wouldn't want anyone forging who messages are sent from!
  params[:message][:sender] = current_user.username

  message = Message.create(params[:message])

  flash[:notice] = "Message sent."

  redirect "/hackers/#{message.recipient}"
end

# This is the page where you can see your messages.
get "/messages" do
  require_login!

  # Let's sort them in descending order.
  @messages = Message.all({"recipient" => current_user.username}).sort do |a, b|
    b.created_at <=> a.created_at
  end
  haml :"messages/index"
end

