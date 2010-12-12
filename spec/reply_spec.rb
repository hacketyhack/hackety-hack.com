describe Reply do

  describe "subscriptions" do
    it "adds one to its Discussion upon creation" do
      email = "someone@example.com"
      @discussion = Factory(:discussion)
      @discussion.should_receive(:create_subscription!)
      @discussion.replies << Factory(:reply, :author_email => email)
      @discussion.save
    end

    it "triggers an email to others upon creation"
  end

end
