class BlogController < ApplicationController
  def show
    @posts = BlogPost.all.reverse
  end

  def create
    @post = BlogPost.create(params[:blog_post])
    redirect_to admin_blog_path, :notice => "Blog Post created!"
  end

  def admin
    @post = BlogPost.new
    @posts = BlogPost.all.reverse
  end
end
