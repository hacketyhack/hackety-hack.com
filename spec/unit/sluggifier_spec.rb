# encoding: utf-8

require 'active_support/all'
require_relative '../../lib/sluggifier'

describe Sluggifier do
  describe '.generate' do
    it "makes a slug from a title" do
      Sluggifier.generate('test a slug').should == 'test-a-slug'
    end

    context "doesn't allow multiple slugs to be the same" do
        let(:all_slugs) { ['test'] }

      it "appends a one if there is one repeated slug" do
        Sluggifier.generate('test',all_slugs).should == 'test-2'
      end

      it "appends the next sequential number for repeats" do
        all_slugs << 'test-2'
        Sluggifier.generate('test',all_slugs).should == 'test-3'
      end
    end
  end


end
