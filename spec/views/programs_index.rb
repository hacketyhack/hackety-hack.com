require 'spec_helper'

describe 'programs/index.html.haml' do
   context 'programs without a username' do
     it "renders the page without error" do
       programs = [Fabricate(:program, author_username: nil)]
       assign(:programs, programs)
       render
       rendered.should have_selector('div', id: 'title', contents: 'MyString')
     end
   end
end
