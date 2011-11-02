class Program
  include MongoMapper::Document

  key :author_username, String
  key :slug, String
  key :title, String
  key :source_code, String

  scope :by_username,  lambda { |username| where(:author_username => username) }

  before_create :make_slug

  def make_slug
    unless slug
      all_slugs = Program.where(:author_username => author_username).map(&:slug)
      self.slug = Sluggifier.generate(title)
    end
  end

  def to_param
    slug
  end

end
