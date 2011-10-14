class Program
  include MongoMapper::Document

  key :author_username, String
  key :slug, String
  key :title, String
  key :source_code, String

  scope :by_username,  lambda { |username| where(:author_username => username) }

  def to_param
    slug
  end

end
