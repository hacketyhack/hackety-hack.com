class MessagesController < ApplicationController

  prepend_around_filter ApiAuthorizedFilter.new
  
  #ugly, but here until i can inspect the issue...
  protect_from_forgery :except => :create

  def index
    @messages = Message.find(:all, :conditions => ["recipient_id = ?", current_user.id])
    respond_to do |format|
      format.html
      format.yaml {require 'yaml'; render :text => (Hash.from_xml(@messages.to_xml)).to_yaml}
    end
  end

  def show
    @message = Message.find(params[:id])
    respond_to do |format|
      format.html
      format.yaml {require 'yaml'; render :text => (Hash.from_xml(@message.to_xml)).to_yaml}
    end
  end

  def new
    @message = Message.new
  end

  def edit
    @message = Message.find(params[:id])
  end

  def create
    if params[:recipient_username]
      user = User.find_by_username(params[:recipient_username])
      @message = Message.new
      @message.recipient = user
      @message.sender = current_user
      @message.text = params[:text]
      if @message.save
        require 'yaml'; render :text => (Hash.from_xml(@message.to_xml)).to_yaml
      else
        render :action => "new"
      end
      return
    end

    @message = Message.new(params[:message])
    @message.sender = current_user

		if @message.save
			flash[:notice] = 'Message was successfully created.'
			redirect_to user_path(@message.recipient.username)
		else
			render :action => "new"
		end
  end

  def update
    @message = Message.find(params[:id])

		if @message.update_attributes(params[:message])
			flash[:notice] = 'Message was successfully updated.'
			redirect_to(@message)
		else
			render :action => "edit"
		end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    redirect_to(messages_url)
  end

  def mark_read
    @message = Message.find(params[:id])
    @message.read = true
    @message.save
    redirect_to(@message)
  end
end
