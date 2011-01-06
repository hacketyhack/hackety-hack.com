# This is the class for inter-site messages.
class Message
  include MongoMapper::Document

  key :body, String

  key :recipient, String

  key :sender, String

  timestamps!

  after_create :send_notification

  private

  # Sending emails is a good thing. We wouldn't want you to not realize you
  # have a message! Right now, we explicitly test for development mode, because
  # of some weirdness. I'd much rather remove that `unless`, but I haven't
  # gotten around to figuring it out yet.
  def send_notification
    unless development?
      recipient_email = Hacker.first(:username => self.recipient).email
      Notifier.send_message_notification(recipient_email, self.sender)
    end
  end

end

