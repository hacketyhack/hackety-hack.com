class MailerController < ApplicationController
  def new
    #@user = User.find_by_username(params[:user])
    @users = params[:user]
    if @users.is_a? Array
      @emails = Array.new
      @users.each do |user|
        @emails << User.find_by_username(user).email
      end
    else
      @emails = User.find_by_username(@users).email
    end
  	@message = Message.new
  end

  def create
  	@message = Message.new(params[:message])

  	if @message.valid?
  		MessageMailer.new_message(@message).deliver
  		redirect_to users_index_path, :notice => "Email sent correctly"
  	else
  		notice = "There was an error"
  		reder :new
  	end
  end
end
