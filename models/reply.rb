#this is a reply to a forum discussion
class Reply
  #it's embedded in a discussion
  include MongoMapper::EmbeddedDocument

  #the body of the reply
  key :body, String

  #the person who wrote it
  key :author, String
  key :author_email, String

  #we need to make sure we have an author
  validate_on_create :author_check

  after_save :send_subscription_notice

  private

  def send_subscription_notice
    _root_document.create_subscription! :author_email
  end

  def author_check
    if author.nil?
      errors.add(:author, "Someone must have written this reply!")
    end
  end

end
