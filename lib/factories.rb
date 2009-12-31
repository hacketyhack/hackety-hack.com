Factory.sequence :username do |n|
 "usernumber#{n}"
end

Factory.sequence :email do |n|
 "user#{n}@example.com"
end

Factory.define :user do |u|
  u.username { Factory.next(:username) }
  u.email { Factory.next(:email) }
  u.password "password"
  u.password_confirmation {|user| "#{user.password}"}
end
