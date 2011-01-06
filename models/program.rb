# The `Program` class represents a program that someone's uploaded. Right now
# we only store the latest version as text, but eventually, I'd love for
# programs to be backed by `git`.
class Program
  include MongoMapper::Document

  key :creator_username, String
  key :title, String
  key :slug, String

  # this is the source code for the program.
  key :code, String

  validate_on_create :slug_check
  before_save :make_slug

  many :comments

  timestamps!

  private
  def slug_check
    programs = Program.all(:creator_username => creator_username)
    unless programs.detect {|p| p.slug == title.to_slug }.nil?
      errors.add(:title, "Title needs to be unique")
    end
  end

  def make_slug
    self.slug = self.title.to_slug
  end
end

