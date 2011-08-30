class Question
  include MongoMapper::Document

  key :title, String
  key :description, String

end
