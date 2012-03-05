class BlogController < ApplicationController
  def show
    @posts = BlogPost.all
  end
end
