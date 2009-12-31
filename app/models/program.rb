class Program < ActiveRecord::Base
	belongs_to :user
	has_many :comments

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :text
end
