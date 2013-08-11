require "spec_helper"

describe MessageMailer do
	let(:message) { Fabricate(:message)}

    it "is from Steve" do
      message.from.should eq(["steve@hackety.com"])
    end
end
