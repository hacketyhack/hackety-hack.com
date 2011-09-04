Given /^I have created a question$/ do
  pending
end

Given /^there are existing questions$/ do
  2.times{Fabricate(:question)}
end