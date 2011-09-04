class Question
  include MongoMapper::Document

  key :title, String
  key :description, String

  belongs_to :user
  many :answers

  validates_presence_of :title, :description

end
