class MessageMailer < ActionMailer::Base
  default from: "steve@hackety.com"

  def new_message message 
  	@message = message
  	mail(:to => @message.email, :subject => @message.subject)
  end
end
