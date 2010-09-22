#These are the factory_girl factories for Posts.
#Learn more about factory_girl here: http://github.com/thoughtbot/factory_girl

#just a little factory for a post!
Factory.define :post do |p|
  p.title "default title"
  p.body "This is a body"
  p.slug "default_title"
  p.comments []
end
