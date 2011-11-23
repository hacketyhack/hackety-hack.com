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
