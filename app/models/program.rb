class Program
  include MongoMapper::Document

  key :author_username, String
  key :slug, String
  key :title, String
  key :source_code, String

  def to_param
    slug
  end

end
