class WatchingsController < ApplicationController
	def create
		@watching = current_user.watchings.build(:watches_id => params[:watches_id])
		if @watching.save
			flash[:notice] = "Now watching #{@watching.watches.username}"
			redirect_to root_url
		else
			flash[:error] = "Unable to watch #{@watching.watches.username}."
			redirect_to root_url
		end
	end

	def destroy
		@watching = current_user.watchings.find(params[:id])
		@watching.destroy
		flash[:notice] = "You are no longer watching #{@watching.watches.username}"
		redirect_to user_path(current_user.username)
	end
end
