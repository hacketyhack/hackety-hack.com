require 'spec_helper'

describe 'questions/index.atom.builder' do
  let(:question) { Fabricate(:question) }

  before { assign(:questions, [question]) }

  it "renders the feed without error" do
    render
    rendered.should include(question.title)
    rendered.should include(question.description)
    rendered.should include(question.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))
    rendered.should include(question.user.username)
  end
end
