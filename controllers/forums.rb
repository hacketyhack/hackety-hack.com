#you can view the forums at /forums
get "/forums" do

	#render that template!
	haml :"forums/index"
end

#you can view an individual forum here!
get "/forums/:forum" do
	
	#we use this in the view
	@forum = params[:forum]

	#gotta find all the discussions in this forum
	@discussions = Discussion.all(:forum => params[:forum]).sort{|a,b| a.updated_at <=> b.updated_at}.reverse

	#render the template!
	haml :"forums/show"
end

get "/forums/:forum/discussions/new" do
	@forum = params[:forum]
	haml :"discussions/new"
end

post "/forums/:forum/discussions" do
	params[:author] = current_user.username
	params[:author_email] = current_user.email
	@discussion = Discussion.create(params)
	flash[:notice] = "Discussion created!"
	redirect "/forums/#{params[:forum]}/#{@discussion.slug}"
end

#you view a discussion here
get "/forums/:forum/:discussion" do
	@discussion = Discussion.first(:forum => params[:forum], :slug => params[:discussion])
	haml :"discussions/show"
end

get "/forums/reply/to/:forum/:discussion" do
	@forum = params[:forum]
	@discussion = params[:discussion]
	@discussion_title = Discussion.first(:forum => params[:forum], :slug => params[:discussion]).title

	haml :"forums/reply"
end

post "/forums/reply/to/:forum/:discussion" do
	@discussion = Discussion.first(:forum => params[:forum], :slug => params[:discussion])
	params[:reply][:author] = current_user.username
	params[:reply][:author_email] = current_user.email
	@discussion.replies << Reply.new(params[:reply])
	@discussion.save

	flash[:notice] = "Replied!"
	redirect "/forums/#{params[:forum]}/#{params[:discussion]}"
end
