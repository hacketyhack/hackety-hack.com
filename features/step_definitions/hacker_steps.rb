Given /^the hacker "([^"]*)" is following the hacker "([^"]*)"$/ do |u1, u2|
	follower = Hacker.first(:username => u1)
	followee = Hacker.first(:username => u2)
	follower.follow! followee
end
