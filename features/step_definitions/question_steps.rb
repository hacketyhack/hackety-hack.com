Given /^I have created a question with title "([^"]*)" and description "([^"]*)"$/ do |title, description|
  @user.questions.build(:title => "#{title}", :description =>"#{description}").save!
end

Given /^there are existing questions$/ do
  2.times{Fabricate(:question)}
end

