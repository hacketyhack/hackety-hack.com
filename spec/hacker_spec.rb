describe Hacker do
  it "should generate a slug before_create" do
    hacker = Factory(:hacker)
    hacker.slug.should == hacker.username.to_slug
  end
end
