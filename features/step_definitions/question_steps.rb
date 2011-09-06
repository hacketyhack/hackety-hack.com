Given /^I have created a question with title "([^"]*)" and description "([^"]*)"$/ do |title, description|
  @question = @user.questions.build(:title => "#{title}", :description =>"#{description}")
  @question.save!
end

Given /^there are existing questions$/ do
  2.times{Fabricate(:question)}
end

When /^(?:|I )follow "([^"]*)" for my question$/ do |link|
  find("##{@question.id}").click_link(link)
end
