#this is the class for inter-site messages
class Message
  #we want to include them in the database!
  include MongoMapper::Document

  #this is the body text of the message
  key :body, String

  #this is the username of the person who gets the message
  key :recipient, String

  #this is the username of the person who sent the message
  key :sender, String

  timestamps!

  after_create :send_notification

  private

  def send_notification
    unless development?
      recipient_email = Hacker.first(:username => self.recipient).email
      Notifier.send_message_notification(recipient_email, self.sender)
    end
  end

end

