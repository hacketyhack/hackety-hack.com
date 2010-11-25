require File.dirname(__FILE__) + '/acceptance_helper'

feature "Forums" do
  
  scenario "can view all of them" do
    @hacker = Factory(:hacker)
    log_in @hacker

    visit "/forums"

    page.should have_content "Learning Ruby"
    page.should have_content "Hackety Help"
    page.should have_content "Clubhouse"
  end

  scenario "can view discussions" do
    @hacker = Factory(:hacker)
    log_in @hacker

    title = "I need help!"
    Factory(:discussion, :title => title, :forum => "learning_ruby")

    visit "/forums"
    click_link "Learning Ruby"
    page.should have_content title
  end

  scenario "view replies" do
    @hacker = Factory(:hacker)
    log_in @hacker

    Factory(:discussion_with_reply, :title => "I need help", :forum => "learning_ruby")

    visit "/forums/learning_ruby/i_need_help"
    page.should have_content "I need help"
    page.should have_content "I'm here to help!"
  end

end
