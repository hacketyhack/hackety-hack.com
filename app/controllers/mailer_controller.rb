class MailerController < ApplicationController
  def new
    @users = Array.new 
    Array(params[:user]).each do |user|
      @users << user
    end

    @emails = Array.new
    @users.each do |user|
      @emails << User.find_by_username(user).email
    end

  	@message = Message.new
  end

  def create
  	@message = Message.new(params[:message])

  	if @message.valid?
      @message.email.each do |email|
  		  MessageMailer.new_message(@message, email).deliver
      end
  		redirect_to users_index_path, :notice => "Email sent correctly"
  	else
  		notice = "There was an error"
  		render :new
  	end
  end
end
