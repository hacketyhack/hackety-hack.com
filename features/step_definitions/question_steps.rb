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
  @question = Question.new(:title => "A question",
                           :description => "The description")
  @question.user = @user
  @question.save
end

When /^I edit that question$/ do
  visit "/questions/#{@question.id.to_s}/edit"
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
