class Rel
  include MongoMapper::Document

  key :slug, String
  key :description, String
end
