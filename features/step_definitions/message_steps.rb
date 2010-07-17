Given /^I send a message to "([^"]*)" that says "([^"]*)"$/ do |recipient, body|
	Factory(:message, :recipient => recipient, :body => body)
end

