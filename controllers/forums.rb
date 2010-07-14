#you can view the forums at /forums
get "/forums" do

	#render that template!
	haml :"forums/index"
end

#you can view an individual forum here!
get "/forums/:forum" do
	
	#gotta find all the discussions in this forum
	@discussions = Discussion.all(:forum => params[:forum])

	#render the template!
	haml :"forums/show"
end
