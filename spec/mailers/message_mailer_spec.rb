require "spec_helper"

describe MessageMailer do
  let(:message) { MessageMailer.new_message(Fabricate(:message), Array("proof@example.com"))}

  it "is from Steve" do
    message.from.should eq(["steve@hackety.com"])
  end

  it "Correct subject" do
  	message.subject.should eq("Hackety-hack email")
  end

  it "Correct receiver email" do
  	message.to.should eq(["proof@example.com"])
  end

  it "Correct body" do
  	message.body.encoded.should match("This is an email from hackety-hack.com")
  end
end
