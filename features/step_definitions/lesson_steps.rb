When(/^I visit lessons path$/) do
  visit lessons_path
end

Then(/^I should see the list of lessons$/) do
  page.should have_content("Lessons")
  page.should have_content("A Tour of Hackety Hack")
end

When(/^I click on lesson's title$/) do
  click_link("A Tour of Hackety Hack")
end

Then(/^I should see lesson content$/) do
  expect(page).to have_title "A Tour of Hackety Hack"
  page.should have_content("Welcome to the Hackety Hack tour!")
end
