class MailerController < ApplicationController
  def new
    @user = User.find_by_username(params[:user])
  	@message = Message.new
  end

  def create
  	@message = Message.new(params[:message])
 #   @message.email = params[:email]

  	if @message.valid?
  		MessageMailer.new_message(@message).deliver
  		redirect_to users_index_path, :notice => "Email sent correctly"
  	else
  		notice = "There was an error"
  		reder :new
  	end
  end
end
