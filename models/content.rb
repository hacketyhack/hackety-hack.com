# Content is a model that represents the different things that can be put into
# the stream.
class Content
  include MongoMapper::Document

  # Current type values are question, link, and post
  key :type, String

  key :body, String

  key :author, String
  key :author_email, String

  # we want to embed comments.
  many :comments

  timestamps!
 
  # This shows the avatar of the author.
  def image
    require 'digest/md5'
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(author_email.downcase)}"
  end

end
