Given /^a question exists$/ do
  login_user
  create_question_for(@user)
end

Given /^I answer that question$/ do
  visit new_question_answer_path(@question)
  fill_in "Answer", with: "Have you tried turning it off and on again?"
  click_button "Post Answer"
end

Then /^I should be notified that my answer was submitted$/ do
  page.should have_content("Answer Posted")
end

Then /^I should be able to see my answer$/ do
  page.should have_content("#{@user.username} says")
  page.should have_content("Have you tried turning it off and on again?")
end

Then /^my answer should show on my profile page$/ do
  visit user_path(@user)
  page.should have_content(@question.title)
  page.should have_content("Have you tried turning it off and on again?")
end

Then /^an email should be sent to the author$/ do
  ActionMailer::Base.deliveries.should_not be_empty
end

When /^I edit that answer$/ do
  visit question_path(@question)
  page.find('.answer > .links').click_link('Edit')
  fill_in 'Answer', with: 'Edit: Did you try magic?'
  click_button 'Post Answer'
end

Then /^I should see the updated answer$/ do
  page.should have_content("#{@user.username} says")
  page.should have_content('Edit: Did you try magic?')
end

Then(/^I should see captcha$/) do
  page.should have_css('.simple_captcha')
  page.should have_css('.simple_captcha_image')
  page.should have_css('.simple_captcha_field')
end