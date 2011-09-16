class Question
  include MongoMapper::Document

  key :title, String
  key :description, String
  key :solution_id, ObjectId
  timestamps!

  belongs_to :user
  many :answers
  
  one :answer, :in => :solution_id

  validates_presence_of :title, :description

  scope :newest_first, sort(:created_at.desc)

end
