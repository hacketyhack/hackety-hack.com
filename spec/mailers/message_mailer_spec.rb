require "spec_helper"

describe MessageMailer do
	let(:message) { MessageMailer.new_message(Fabricate(:message), Array("proof@example.com"))}

  it "is from Steve" do
    message.from.should eq(["steve@hackety.com"])
  end
end
