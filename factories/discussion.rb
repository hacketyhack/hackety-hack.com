Factory.define :discussion do |d|
  d.author "jane_hacker"
  d.author_email "jane_hacker@example.com"
end
Factory.define :discussion_with_reply, :parent => :discussion do |t|
  t.replies {|r| [Factory(:reply)] }
end

Factory.define :reply do |r|
  r.body "I'm here to help!"
  r.author "john_hacker"
  r.author_email "john_hacker@example.com"
end
