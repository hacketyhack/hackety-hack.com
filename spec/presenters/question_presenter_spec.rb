require 'spec_helper'

describe QuestionPresenter do
  
  let(:question){Fabricate(:question)}
  let(:another_question){Fabricate(:question, :id => 'AnotherID')}
  let(:answer){Fabricate(:answer, :question_id => question.id)}

  before do
    @qp = QuestionPresenter.new(question)
  end

  context 'collection_path' do
    it 'returns questions_path' do
      @qp.collection_path.should == '/questions'
    end
  end

  context 'edit_resource_path' do
    it 'returns edit_question_path' do
      @qp.edit_resource_path.should == '/questions/RandomID/edit'
    end
  end

  context 'new_resource_path' do
    it 'returns new_question_path' do
      @qp.new_resource_path.should == '/questions/new'
    end
  end

  context 'resource_path' do
    it 'returns self question path if nil' do
      @qp.resource_path(nil).should == '/questions/RandomID'
    end

    it 'returns question path if not nil' do
      @qp.resource_path(another_question).should == '/questions/AnotherID'
    end
  end

  context 'answers_path' do
    it 'returns questions answer path' do
      @qp.answers_path.should == '/questions/RandomID/answers'
    end
  end
end