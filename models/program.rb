class Program
  include MongoMapper::Document
  key :creator_username, String
  key :title, String
  key :slug, String
  key :code, String

  validate_on_create :slug_check
  before_save :make_slug

  many :comments

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

