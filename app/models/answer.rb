class Answer
  include MongoMapper::Document

  key :description, String

  validates_presence_of :description

  belongs_to :question
  belongs_to :user

end
