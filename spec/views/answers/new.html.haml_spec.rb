require 'spec_helper'

describe "answers/new.html.haml" do
  before(:each) do
    assign(:answer, stub_model(Answer,
      :description => "MyString",
      :user => ""
    ).as_new_record)
  end

  it "renders new answer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => answers_path, :method => "post" do
      assert_select "input#answer_description", :name => "answer[description]"
      assert_select "input#answer_user", :name => "answer[user]"
    end
  end
end
