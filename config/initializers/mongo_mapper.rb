if ENV['MONGOHQ_URL']
  MongoMapper.config = {
    Rails.env => { 'uri' => ENV['MONGOHQ_URL'] }
  }

  MongoMapper.connect(Rails.env)
else
  MongoMapper.database = "hackety-hack-com-#{Rails.env}"
end
