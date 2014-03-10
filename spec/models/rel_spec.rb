require 'spec_helper'

describe Rel do
  
  before do
    @rel = Rel.create(:slug => 'text', :description => 'some text')
  end
  
  context 'to_param' do
    it 'returns slug' do
      @rel.to_param.should == 'text'
    end
  end
end