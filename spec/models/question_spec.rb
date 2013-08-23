require 'spec_helper'

describe Question do

  let(:question){Fabricate(:question)}

  it 'can be created validly' do
    question.should be_valid
  end

  describe 'without a user' do
    before :each do
      question.user.destroy
      @reloaded_question = Question.find question.id
    end

    it 'does not respond with nil when asked for its user' do
      @reloaded_question.user.should_not be_nil
    end

    it 'responds with something when ask for user that respodns to username' do
      @reloaded_question.user.should respond_to :username
    end
  end
end