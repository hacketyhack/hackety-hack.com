Given /^there's a discussion named "([^"]*)" in "([^"]*)"$/ do |title, forum|
  Factory(:discussion, :title => title, :forum => forum)
end

Given /^there's a discussion named "([^"]*)" in "([^"]*)" with a reply$/ do |title, forum|
  Factory(:discussion_with_reply, :title => title, :forum => forum)
end
