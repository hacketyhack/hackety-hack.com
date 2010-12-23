class Content
  include MongoMapper::Document

  key :type, String #current values are question, link, and post
  key :body, String

  key :author, String
  key :author_email, String
 
  def image
    require 'digest/md5'
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(author_email.downcase)}"
  end

end
