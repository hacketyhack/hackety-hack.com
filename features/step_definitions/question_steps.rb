def create_question_for(user) 
  @question = Question.new(:title => "A question",
                           :description => "The description")
  @question.user = user
  @question.save
end

When /^I create a new question$/ do
  step %{a logged in user}
  visit new_question_path
  fill_in("Title", with: "My Question")
  fill_in("Description", with: "My Description")
  click_button "Ask Everyone"
end

Then /^I should be told the question was created$/ do
  page.should have_content("Question Asked")
end

Then /^I should be able to see the new question$/ do
  click_link("My Question")
  page.should have_content("My Question")
  page.should have_content("My Description")
end

Given /^I am a user that has created a question$/ do
  step %{a logged in user}
  create_question_for(@user)
end

When /^I edit that question$/ do
  visit edit_question_path(@question)
  fill_in "Title", with: "An edited question"
  fill_in "Description", with: "Just a quick edit"
  click_button "Ask Everyone"
end

Then /^I should be told the question was updated$/ do
  page.should have_content("successfully updated")
end

Then /^I should see that the question was updated$/ do
  page.should have_content('An edited question')
  page.should have_content('Just a quick edit')
end

Then /^I should be able to see the question on my profile page$/ do
  visit user_path(@user)
  page.should have_content("My Question")
end

Given /^I am a moderator$/ do
  step %{a logged in user}
  @user.moderator = true
  @user.save
end

Given /^I am not a moderator$/ do
  step %{a logged in user}
  @user.moderator = false
  @user.save
end

Given /^there is a question from someone else$/ do
  @question = Question.create(:title => "A question to delete",
                  :description => "moderator should delete me!",
                  :user => Fabricate(:user))
end

Then /^I can delete that question$/ do
  visit question_path(@question)
  page.should have_content('Delete')
end

Then /^I cannot delete that question$/ do
  visit question_path(@question)
  page.should_not have_content('Delete')
end

Given /^(\w*)\s?questions exist$/ do |type|
  30.times do
    Question.create(title: 'Test', description: 'Test',
    support: type == 'support' ? true : false)
  end
end

When /^I visit the (\w*)\s?questions page$/ do |type|
  visit(type == 'support' ? support_questions_path : questions_path)
end

Then /^I should see a link to the next page of (\w*)\s?questions$/ do |type|
  href = type == 'support' ? '/support/questions?page=2' : '/questions?page=2'
  page.should have_link '2', href: href
end
