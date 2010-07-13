#people can get a form to send messages here
get "/messages/new/to/:username" do
	#we've got to save the username to put it in the view
	@username = params[:username]

	#render the template
	haml :"messages/new"
end

#this is where the form POSTs to
post "/messages" do
	#make a new message with our params
	message = Message.create(params[:message])

	#set a friendly message
	flash[:notice] = "Message sent."

	#render the page of the recipient
	redirect "/hackers/#{message.recipient}"
end
