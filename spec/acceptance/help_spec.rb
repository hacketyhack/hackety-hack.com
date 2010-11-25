require File.dirname(__FILE__) + '/acceptance_helper'

feature "Help" do

  scenario "shows contributor information" do
    visit "/help"
    click_link "GitHub"
    should_be_on "/hacketyhack/hacketyhack"
  end

end
