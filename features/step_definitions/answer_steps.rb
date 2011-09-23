Given /^that someone has provided "([^"]*)" as an answer for my question$/ do |solution|
  other_user = Fabricate(:user)
  other_user.save!
  @question.answers.build(:description => solution, :user => other_user).save!
end
