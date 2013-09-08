class Authentication
  #include Mongoid::Document ## OK...I went nutz here..

  #field :provider, String, :default => ''
  #field :uid, String, :default => ''
  #embedded_in :user

  include MongoMapper::Document
  belongs_to :user


end
