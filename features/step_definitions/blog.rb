Given /^there is a blog post with the title "([^"]*)"$/ do |title|
	Factory(:post, :title => title)
end

