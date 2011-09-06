class Question
  include MongoMapper::Document

  key :title, String
  key :description, String
  key :solution_id, ObjectId

  belongs_to :user
  many :answers
  
  one :answer, :in => :solution_id

  validates_presence_of :title, :description

end
