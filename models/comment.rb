# Comments are an embedded document that's inside of a few different things:
# content, programs, and maybe other stuff in the future. They're really
# simple: Just some text, the person who said it, and their email address. The
# author should be the slug. Having the email lets us show their avatar easily.
class Comment
  include MongoMapper::EmbeddedDocument

  key :body, String

  key :author, String
  key :author_email, String

end
