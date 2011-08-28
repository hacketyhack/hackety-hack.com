class Rel
  include MongoMapper::Document

  key :slug, String
  key :description, String

  def to_param
    slug
  end
end
