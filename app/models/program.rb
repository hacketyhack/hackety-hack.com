class Program
  include MongoMapper::Document

  key :author_username, String
  key :slug, String
  key :title, String
  key :source_code, String
  key :featured, Boolean
  timestamps!

  scope :by_username,  lambda { |username| where(:author_username => username) }
  scope :featured, where(:featured => true)

  before_create :make_slug

  def make_slug
    if slug.blank?
      all_slugs = Program.where(:author_username => author_username).map(&:slug)
      self.slug = Sluggifier.generate(title, all_slugs)
    end
  end

  def to_param
    slug
  end


end
