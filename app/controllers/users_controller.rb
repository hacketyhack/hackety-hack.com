class UsersController < ApplicationController

	def new  
		@user = User.new  
	end  
	 
	def create  
		@user = User.new(params[:user])  
		if @user.save  
			steve = User.first
			steve.watchings.build(:watches_id => @user.id).save
			@user.watchings.build(:watches_id => 1).save
			flash[:notice] = "Registration successful."  
			redirect_to user_path(@user.username)
		else  
			render :action => 'new'  
	 	end  
	end  

	def edit
		@user = current_user
	end

	def update
		@user = current_user
		if @user.update_attributes(params[:user])
			flash[:notice] = "Successfully updated profile."
			redirect_to user_path(@user.username)
		else
			render :action => "edit"
		end
	end

	def show
		@user = User.find_by_username(params[:username])
	end
end
