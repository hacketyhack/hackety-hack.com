class BlogPost
  include MongoMapper::Document

  key :title, String, :required => true
  key :content, String, :required => true

  timestamps!
end
