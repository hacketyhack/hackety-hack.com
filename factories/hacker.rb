#These are the factory_girl factories for Hackers.
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

#this is the factory for the admin.
Factory.define :admin, :parent => :hacker do |u|
  #feel the power!!!
  u.admin true
end
