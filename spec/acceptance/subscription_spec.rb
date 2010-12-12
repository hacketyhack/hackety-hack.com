require File.dirname(__FILE__) + '/acceptance_helper'

feature "Subscriptions" do

  scenario "Subscribing to a thread" do

#   Given I've commented in a thread
    thread = Factory(:discussion)
    me = Factory(:hacker)
    reply = Factory(:reply, :author => me.username, :author_email => me.email)
    thread.replies << reply

    Pony.should_receive(:deliver) do |mail|
      mail.to.should == [ me.email ]
      mail.body.to_s.should =~ /\/forums\/#{thread.forum}\/#{thread.slug}/
    end

#   When someone else makes a comment
    somebody = Factory(:hacker)
    log_in somebody
    visit "/forums/#{thread.forum}/#{thread.slug}"
    click_link "Reply"
    fill_in "Body", :with => "Here's my take on things: Dream big!"
    click_button "Create Reply"

#   Then I should receive an email
#   (see pony block above)

#   And it should have a link to that thread
#   (see pony block above)

  end

# Scenario: Unsubscribing from a thread
#   Given I've subscribed to a thread
#   And I'm on the page for that thread
#   When I click the unsubscribe link
#   And someone makes a comment
#   Then I should not receive an email

# Scenario: Subscribing to a forum
#   Given I'm on the index page for a forum
#   When I click the subscription link
#   And someone makes a new thread in that forum
#   Then I should receive an email
#   And it should have a link to that forum

# Scenario: Unsubscribing from a forum
#   Given I've subscribed to a forum
#   And I'm on the index page for that forum
#   When I click the unsubscribe link
#   And someone makes a new thread in that forum
#   Then I should not receive an email

end
