class BlogController < ApplicationController
  before_filter :authenticate_user!, :only => [:admin, :create]

  def index
    @posts = BlogPost.all.reverse
  end

  def show
    @post = BlogPost.find(params[:id])
  end

  def admin
    redirect_to blog_index_path unless current_user.blog_poster
    @post = BlogPost.new
    @posts = BlogPost.all.reverse
  end

  def create
    redirect_to blog_index_path and return unless current_user.blog_poster
    @post = BlogPost.create(params[:blog_post])
    redirect_to admin_blog_index_path, :notice => "Blog Post created!"
  end
end
