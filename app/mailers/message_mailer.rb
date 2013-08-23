class MessageMailer < ActionMailer::Base
  default from: "steve@hackety.com"

  def new_message message 
  	@message = message
  	@message.email.each do |email|
  		mail(:to => email, :subject => @message.subject)
  	end
  end
end
