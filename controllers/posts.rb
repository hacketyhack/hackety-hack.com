# This is the controller for blog posts.


# We can access the blog at /blog
get "/blog" do
	#first we find all posts
	@posts = Post.all

	#and then we render our template
	haml :'posts/index'
end

#Admin users can make new posts at /posts/new
get "/posts/new" do
	#make sure we only let in admins!
	admin_only!

	#render the template
	haml :'posts/new'
end

#When a new post is made, it sends a POST request to /posts
post "/posts" do
	#make sure we only let in admins!
	admin_only!

	#make the post with the given params
	@post = Post.create(params)

	#set a friendly message
	flash[:notice] = "Post Created"

	#go check out that post
	redirect "/posts/#{@post.id}" 
end

#for completeness, we can also see every post at /posts
get "/posts" do
	#grab all of the posts
	@posts = Post.all

	#render the template
	haml :'posts/index'
end

#an individual post can be seen at /posts/:id
get "/posts/:id" do
	#find the post with that id
	@post = Post.find(params[:id])

	#render our template
	haml :'posts/show'
end

#admins can edit posts at /posts/:id/edit
get "/posts/:id/edit" do
	#make sure we only let in admins!
	admin_only!

	#find the post with the right id
	@post = Post.find(params[:id])

	#render our template
	haml :'posts/edit'
end

#to update a post, send a PUT request to /posts/:id
put "/posts/:id" do
	#make sure we only let in admins!
	admin_only!

	#find the post with the right id
	@post = Post.find(params[:id])

	#update its info
	@post.update_attributes(params)

	#set a friendly message
	flash[:notice] = "Post Modified"

	#and visit that post
	redirect "/posts/#{@post.id}"
end

#I've included comments in here too, because comments can only be made on posts
#make a new comment by sending a POST request to /comments
post "/comments" do
	#we need to be logged in to comment
	#if we fail, return to /posts
	require_login! :return => "/posts"

	#set the email of the comment to our email
	params[:comment]['author'] = current_user.username

	#find the post we want to comment on
	@post = Post.find(params[:post_id])

	# create our new comment and add it to the posts' comments
	@post.comments << Comment.new(params[:comment])
	@post.save

	#set a helpful message
	flash[:notice] = "Thanks for your comment!"

	#go back to the page for that post
	redirect "/posts/#{@post.id}" 
end
