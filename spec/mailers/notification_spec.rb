require "spec_helper"

describe Notification do
  describe "new_answer" do
    let(:question) { Fabricate(:question) }
    let(:mail) { Notification.new_answer(question) }

    it "has a link to the question" do
      mail.body.encoded.should match(question_url(question, :host => "hackety.com"))
    end

    it "is from Steve" do
      mail.from.should eq(["steve@hackety.com"])
    end

    it "is to the question's author" do
      mail.to.should eq([question.user.email])
    end

    it "has the proper subject" do
      mail.subject.should eq("New Answer on Hackety.com!")
    end
  end
end
