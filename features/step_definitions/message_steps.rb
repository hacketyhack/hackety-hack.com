Given /^I send a message to "([^"]*)" that says "([^"]*)"$/ do |recipient, body|
  Factory(:hacker, :username => recipient)
  Factory(:message, :recipient => recipient, :body => body)
end

