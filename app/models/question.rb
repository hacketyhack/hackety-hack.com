class Question
  include MongoMapper::Document

  key :title, String
  key :description, String

  belongs_to :user

end
