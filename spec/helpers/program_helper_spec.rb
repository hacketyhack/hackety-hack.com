require "spec_helper"

describe ProgramsHelper do
  let(:simple) { Fabricate(:program) }
  let(:complicated) { Fabricate(:program, :author_username => nil) }

  describe "#program_link" do
    it "returns author's program path if author username exists" do
      helper.program_link(simple).should == "#{link_to(simple.title.titleize, 
                                               user_program_path(simple.author_username, simple))}".html_safe
    end

    it "returns url by program's slug if author username doesn't exist" do
      helper.program_link(complicated).should == "#{link_to(complicated.title.titleize, 
                                                    url_for(:controller => '/programs', 
                                                            :action => 'show', 
                                                            :id => complicated.slug))}".html_safe
    end
  end
end