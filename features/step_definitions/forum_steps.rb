Given /^there's a discussion named "([^"]*)" in "([^"]*)"$/ do |title, forum|
  Factory(:discussion, :title => title, :forum => forum)
end

Given /^there's a discussion named "([^"]*)" in "([^"]*)" with a reply$/ do |title, forum|
  Factory(:discussion_with_reply, :title => title, :forum => forum)
end

Given /^there's a discussion$/ do
  @discussion ||= Factory(:discussion)
end


Then /^I should see the discussion's forum name$/ do
  forum = @discussion.forum_name
  Then "I should see \"#{forum}\""
end

