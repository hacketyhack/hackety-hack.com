require File.dirname(__FILE__) + '/acceptance_helper'

feature "Messages" do

  scenario "can be sent" do
    Pony.should_receive(:deliver)

    @hacker = Factory(:hacker)
    log_in @hacker

    @fela = Factory(:hacker, :username => "fela")

    visit "/hackers/fela"

    click_link "Send fela a message"
    fill_in "Message text", :with => "Hello, fela!"

    click_button "Send message"

    should_be_on "/hackers/fela"
    page.should have_content "Message sent."
  end

  
  scenario "can only be sent when logged in" do
    @hacker = Factory(:hacker)
    visit "/logout"

    @fela = Factory(:hacker, :username => "fela")

    visit "/hackers/fela"
    page.should_not have_content "Send fela a message"
  end

  scenario "can only see messages sent to me" do
    Pony.should_receive(:deliver)
    @steve = Factory(:hacker, :username => "steve")
    @fela = Factory(:hacker, :username => "fela")

    Factory(:message, 
            :sender => @steve.username, 
            :recipient => @fela.username, 
            :body => "Hello, fela!")

    visit "/logout"

    log_in @fela

    visit "/messages"

    page.should have_content "Hello, fela!"
    page.should have_content "From: steve"
  end

  scenario "has an inbox link" do
    @hacker = Factory(:hacker)
    log_in @hacker

    page.should have_content "Inbox"
  end
end
