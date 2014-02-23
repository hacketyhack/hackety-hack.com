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

Given /^I'm logged in as someone who can post to the blog$/ do
  step %{a logged in user}
  @user.blog_poster = true
  @user.save
end

When /^I visit the blog admin page$/ do
  visit "/blog/admin"
end

When /^I fill out the new blog form$/ do
  #this is silly
  @post = OpenStruct.new
  @post.title = "A title"

  fill_in :blog_post_title, :with => "A title"
  fill_in :blog_post_content, :with => "Some content"
end

When /^I press "([^"]*)"$/ do |name|
  click_button name
end

Then /^I should see that my post has been created$/ do
  page.should have_content("Post created!")
end

When /^I visit a blog post$/ do
  visit blog_path(@post)
end

