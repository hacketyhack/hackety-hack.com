get "/blog" do
	@posts = Post.all
	haml :'posts/index'
end

get "/posts/new" do
	unless logged_in? && current_user.admin?
		flash[:error] = "Sorry, buddy"
		redirect "/posts"
	end

	haml :'posts/new'
end

post "/posts" do
	unless logged_in? && current_user.admin?
		flash[:error] = "Sorry, buddy"
		redirect "/posts"
	end

	@post = Post.create(params)
	flash[:notice] = "Post Created"
	redirect "/posts/#{@post.id}" 
end

get "/posts" do
	@posts = Post.all
	haml :'posts/index'
end

get "/posts/:id" do
	@post = Post.find(params[:id])
	haml :'posts/show'
end

get "/posts/:id/edit" do
	unless logged_in? && current_user.admin?
		flash[:error] = "Sorry, buddy"
		redirect "/posts"
	end

	@post = Post.find(params[:id])
	haml :'posts/edit'
end

put "/posts/:id" do
	unless logged_in? && current_user.admin?
		flash[:error] = "Sorry, buddy"
		redirect "/posts"
	end
	@post = Post.find(params[:id])
	@post.update_attributes(params)
	flash[:notice] = "Post Modified"
	redirect "/posts/#{@post.id}"
end

post "/comments" do
	unless current_user
		flash[:error] = "You must be logged in to comment!"
		redirect "/posts"
	end

	params[:comment]['user_email'] = current_user.email
	@post = Post.find(params[:post_id])
	@post.comments << Comment.new(params[:comment])
	@post.save
	flash[:notice] = "Thanks for your comment!"
	redirect "/posts/#{@post.id}" 
end
