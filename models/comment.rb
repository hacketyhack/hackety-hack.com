class Comment
  include MongoMapper::EmbeddedDocument

  #the body of the comment
  key :body, String

  #the person who wrote it
  key :author, String
  key :author_email, String

end
