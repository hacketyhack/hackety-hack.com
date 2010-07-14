Given /^there's a discussion named "([^"]*)" in "([^"]*)"$/ do |title, forum|
	Factory(:discussion, :title => title, :forum => forum)
end
