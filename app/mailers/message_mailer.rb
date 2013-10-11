class MessageMailer < ActionMailer::Base
  default from: "steve@hackety.com"

  def new_message message, email
  	@message = message
  	@email = email
  	mail(:to => @email, :subject => @message.subject)
  end
end
