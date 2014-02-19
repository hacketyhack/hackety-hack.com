  Given /^there is a featured program$/ do
  @program = Program.create!(:author_username => "username",
                              :slug => "slug",
                              :title => "My Featured Program",
                              :featured => true)
end

Then /^I should be able to view a highlighted program$/ do
  visit programs_path
  within "#featured" do
    page.should have_content("My Featured Program")
  end
end

def upload_program(user)
  @program = Program.create!(:author_username => user.username,
                              :slug => "slug",
                              :title => "#{user.username}'s program",
                              :source_code => "puts 'Hello world'")
end

Given /^I have uploaded a program$/ do
  upload_program(@user)
end

Given /^a user has uploaded a program$/ do
  @user = User.create!(:username => "some_user",
                        :password => "password",
                        :password_confirmation => "password",
                        :email => "some_user@example.com")
  upload_program(@user)
end

Given /^they have given their program a description$/ do
  @program = Program.last
  @program.description = "A really cool program!"
  @program.save
end


def visit_user_programs_page
  visit user_path(@user)
  within ".about-user" do
    find(".user-programs").click()
  end
  page.should have_content(@program.title.titleize)
end

Then /^I should be able to view my programs$/ do
  visit_user_programs_page
end

Then /^I should be able to view their programs$/ do
  visit_user_programs_page
end

When /^I click the first program link$/ do
  within "#all-programs ul" do
    first("li:first-child a").click()
  end
end

Then /^I should see the program source$/ do
  within("#program") do
    page.should have_content("puts 'Hello world'")
  end
end

Then /^I should see the description of their program$/ do
  page.should have_content("A really cool program!")
end
