class BlogController < ApplicationController
  def index
    @posts = BlogPost.all.reverse
  end

  def create
    @post = BlogPost.create(params[:blog_post])
    redirect_to admin_blog_index_path, :notice => "Blog Post created!"
  end

  def show
    @post = BlogPost.find(params[:id])
  end

  def admin
    @post = BlogPost.new
    @posts = BlogPost.all.reverse
  end
end
