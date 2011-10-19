class Question
  include MongoMapper::Document

  key :title, String
  key :description, String
  key :solution_id, ObjectId
  key :support, Boolean
  timestamps!

  belongs_to :user
  many :answers

  validates_presence_of :title, :description

  scope :newest_first, sort(:created_at.desc)
  scope :supports, where(:support => true )
  scope :no_supports, where(:support => nil)
end
