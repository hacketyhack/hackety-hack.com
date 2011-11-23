require 'spec_helper'

describe Program do
    let(:prog) { Program.create(author_username: 'tester', title: 'test title')}
  it "sets the slug" do
    prog.slug.should == 'test-title'
  end

  it "makes unique slugs" do
    first_prog = Program.create(author_username: 'tester', 
                   title: 'test title #2',
                   slug: 'test-title')
    prog.slug.should_not == first_prog.slug
  end
end
