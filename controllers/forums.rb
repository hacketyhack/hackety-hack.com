#you can view the forums at /forums
get "/forums" do

	#render that template!
	haml :"forums/index"
end

#you can view an individual forum here!
get "/forums/:forum" do
	
	#we use this in the view
	@forum = params[:forum]

	#this is kind of an ugly way to do this.
	@forum_name,
	@forum_description =
		case @forum
		when 'learning_ruby'
			["Learning Ruby",
				"A place to learn about the Ruby programming language."]
		when 'hackety_help'
			["Hackety Help",
				"Have a question about Hackety? You're in the right place!"]
		when 'clubhouse'
			["The Clubhouse",
				"A place to talk to other Hackers about anything you'd like to talk about."]
		end

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
