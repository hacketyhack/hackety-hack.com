class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment])
		@comment.user = current_user

		if @comment.save
			flash[:notice] = 'Comment was successfully created.'
			redirect_to(@comment.program)
		else
			render :action => "new"
		end
  end

end
