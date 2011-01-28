#These are the factory_girl factories, for testing.
#Learn more about factory_girl here: http://github.com/thoughtbot/factory_girl

#this is an email sequence, so we don't use the same email over and over!
Factory.sequence :email do |n|
  "user#{n}@example.com"
end

#this factory defines a hacker
Factory.define :hacker do |u|
  u.username "steve"
  u.email { Factory.next(:email) }
  u.password "foobar"
  #we need to set the password_confirmation to the same value as the password
  u.password_confirmation {|user| user.password }
  u.admin false
end

Factory.define :message do |m|
end

Factory.sequence :program_title do |n|
  "Program #{n}"
end
Factory.define :program do |p|
  p.title { Factory.next(:program_title) }
  p.code "puts 'hello world'"
end

Factory.define :discussion do |d|
  d.forum "learning_ruby"
  d.title "A discussion"
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

