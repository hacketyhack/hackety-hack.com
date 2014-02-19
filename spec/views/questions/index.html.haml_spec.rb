require 'spec_helper'

describe 'questions/index.html.haml' do
  let(:question) { Fabricate(:question) }

  before(:each) do
    # stub the partials and test them individually
    stub_template "shared/_ask" => ""
    stub_template "questions/_list" => ""

    view.stub :will_paginate
  end

  it "renders an autodiscovery link in for the head content" do
    render :template => "questions/index.html.haml", :locals => {:collection => [question]}
    
    view.content_for(:head).should include(questions_url(format: :atom))
  end
end