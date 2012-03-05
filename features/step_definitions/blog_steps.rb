Given /^a blog post exists$/ do
  @post = Fabricate(:blog_post)
end

When /^I visit the blog$/ do
  visit "/blog"
end

Then /^I should see the content of that post$/ do
  page.should have_content(@post.content)
end

Then /^I should see the title of that post$/ do
  page.should have_content(@post.title)
end
