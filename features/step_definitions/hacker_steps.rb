Given /^the hacker "([^"]*)" is following the hacker "([^"]*)"$/ do |u1, u2|
	follower = Hacker.first(:username => u1)
	followee = Hacker.first(:username => u2)
	follower.follow! followee
end


Given /^I have some programs$/ do
  (rand(5) + 1).times do |n|
    hacker.programs << Factory(:program)
  end
end

Then /^I should see links to my programs$/ do
  hacker.programs.each do |program|
    Then "I should see \"#{program.title}\" within \"a\""
  end
end

