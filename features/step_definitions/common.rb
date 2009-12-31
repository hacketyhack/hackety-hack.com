Given /^there's a user named (\w+)$/ do |name|
  Factory(:user, :username => name)
end

