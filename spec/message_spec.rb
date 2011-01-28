describe Message do

  describe "#send_notification" do

    before :each do
      @to = Factory(:hacker, :username => "steve")
      @from = Factory(:hacker, :username => "fela")
    end

    it "creates an email" do
      Pony.should_receive(:deliver)
      @message = Factory(:message, :sender => @from.username, :recipient => @to.username)
    end

    it "is addressed to the recipient" do
      Pony.should_receive(:deliver) do |mail|
        mail.to.should == [ @to.email ]
      end
      @message = Factory(:message, :sender => @from.username, :recipient => @to.username)
    end

    it "is from steve's email" do
      Pony.should_receive(:deliver) do |mail|
        mail.from.should == [ "steve+hackety@steveklabnik.com" ]
      end
      @message = Factory(:message, :sender => @from.username, :recipient => @to.username)
    end

    it "is signed with a signature" do
      Pony.should_receive(:deliver) do |mail|
        mail.body.to_s.should =~ /The Hackety Hack Robot/
      end
      @message = Factory(:message, :sender => @from.username, :recipient => @to.username)
    end

    it "has the correct subject" do
      Pony.should_receive(:deliver) do |mail|
        mail.subject.should == 'Hackety Hack: New Message'
      end
      @message = Factory(:message, :sender => @from.username, :recipient => @to.username)
    end
  end

end

