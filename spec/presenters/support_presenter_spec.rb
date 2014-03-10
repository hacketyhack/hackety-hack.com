require 'spec_helper'

describe SupportPresenter do
  
  let(:question){Fabricate(:question)}
  let(:another_question){Fabricate(:question, :id => 'AnotherID')}

  before do
    @sp = SupportPresenter.new(question)
  end

  context 'page_title' do
    it 'returns support questions title' do
      @sp.page_title.should == 'Support Questions'
    end
  end

  context 'collection_path' do
    it 'returns support questions_path' do
      @sp.collection_path.should == '/support/questions'
    end
  end

  context 'edit_resource_path' do
    it 'returns edit_support_question_path' do
      @sp.edit_resource_path.should == '/support/questions/RandomID/edit'
    end
  end

  context 'new_resource_path' do
    it 'returns new_support_question_path' do
      @sp.new_resource_path.should == '/support/questions/new'
    end
  end

  context 'resource_path' do
    it 'returns self question path if nil' do
      @sp.resource_path(nil).should == '/support/questions/RandomID'
    end

    it 'returns question path if not nil' do
      @sp.resource_path(another_question).should == '/support/questions/AnotherID'
    end
  end
end