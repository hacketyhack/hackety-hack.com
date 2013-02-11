Fabricator(:blog_post) do
  content "Hello, world"
  title "Title"
end

Fabricator(:another_blog_post, from: :blog_post) do
  content "World, Hello"
  title "Eltit"
end
