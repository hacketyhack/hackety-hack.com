Given /^that someone has provided an answer for my question$/ do
  other_user =  Fabricate(:user)
  other_user.save!
  @question.answers.build(:description => "Some solution", :user => other_user).save!
end
