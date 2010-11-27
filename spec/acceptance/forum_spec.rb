require File.dirname(__FILE__) + '/acceptance_helper'

feature "Forums" do

  describe "discussions" do

    scenario "can be viewed" do
      @hacker = Factory(:hacker)
      log_in @hacker

      title = "I need help!"
      Factory(:discussion, :title => title, :forum => "learning_ruby")

      visit "/forums"
      click_link "Learning Ruby"
      page.should have_content title
    end

    scenario "can be created when logged in" do
      @hacker = Factory(:hacker)
      log_in @hacker

      visit "/forums/learning_ruby"
      click_link "New Discussion"

      fill_in "Title", :with => "HALP!"
      fill_in "Body", :with => "I'm really unsure as to how to do something."
      click_button "Submit"

      should_be_on "/forums/learning_ruby/halp"
      page.should have_content "Discussion created!"
      page.should have_content "HALP!"
      page.should have_content "By #{@hacker.username}"
    end

    scenario "can't be created when not logged in" do

      visit "/forums"
      click_link "Learning Ruby"

      page.should_not have_content "New Discussion"
    end

  end

  describe "replies" do

    scenario "can be viewed" do
      @hacker = Factory(:hacker)
      log_in @hacker

      Factory(:discussion_with_reply, :title => "I need help", :forum => "learning_ruby")

      visit "/forums/learning_ruby/i_need_help"
      page.should have_content "I need help"
      page.should have_content "I'm here to help!"
    end

    scenario "can be created when logged in" do
      @hacker = Factory(:hacker)
      log_in @hacker

      Factory(:discussion_with_reply, :title => "I need help", :forum => "learning_ruby")
      visit "/forums/learning_ruby/i_need_help"
      click_link "Reply"
      fill_in "Body", :with => "I'll help you!"
      click_button "Create Reply"
      should_be_on "/forums/learning_ruby/i_need_help"
      page.should have_content "Replied!"
      page.should have_content "I'll help you"
      page.should have_content "#{@hacker.username} says:"
    end

    scenario "can't be created when not logged in" do
      Factory(:discussion, :title => "I need help!", :forum => "learning_ruby")
      
      visit "/forums/learning_ruby/i_need_help"
      page.should_not have_content "Reply"
    end

  end
  
  scenario "can all be viewed" do
    @hacker = Factory(:hacker)
    log_in @hacker

    visit "/forums"

    page.should have_content "Learning Ruby"
    page.should have_content "Hackety Help"
    page.should have_content "Clubhouse"
  end

  scenario "shows breadcrumbs" do
    discussion = Factory(:discussion, :forum => "learning_ruby")
    visit "/forums/learning_ruby/#{discussion.slug}"

    page.should have_content "Hackety Forums"
    page.should have_content "Learning Ruby"
  end

end
