describe Discussion do
  
  describe "#create_subscription!" do

    it "adds a new email to the subscription list" do
      discussion = Factory(:discussion)
      discussion.subscribed_users.count.should == 0
      discussion.create_subscription! "somebody@example.com"
      discussion.subscribed_users.count.should == 1
    end

  end

end
