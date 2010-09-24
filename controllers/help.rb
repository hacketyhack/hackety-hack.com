#this is where we can go to get help
get "/help" do
  haml :"help/index"
end

get "/help/ruby_resources" do
  haml :"help/ruby_resources"
end
