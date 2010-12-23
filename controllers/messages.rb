#people can get a form to send messages here
get "/messages/new/to/:username" do
  #gotta be logged in!
  require_login!

  #we've got to save the username to put it in the view
  @username = params[:username]

  #render the template
  haml :"messages/new"
end

#this is where the form POSTs to
post "/messages" do
  #gotta be logged in!
  require_login!

  params[:message][:sender] = current_user.username

  #make a new message with our params
  message = Message.create(params[:message])

  #set a friendly message
  flash[:notice] = "Message sent."

  #render the page of the recipient
  redirect "/hackers/#{message.recipient}"
end

#this is the page where you can see your messages
get "/messages" do
  require_login!
  @messages = Message.all({"recipient" => current_user.username})
  haml :"messages/index"
end

