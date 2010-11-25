require File.dirname(__FILE__) + '/acceptance_helper'

feature "Messages" do

  background do
    Pony.should_receive(:deliver)
  end

  scenario "can be sent" do
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
end
