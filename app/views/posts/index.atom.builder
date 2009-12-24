atom_feed(:url => "http://feeds.feedburner.com/HacketyHack") do |feed|
  feed.title("Hackety Hack: blog")
  feed.updated(@posts.first ? @posts.first.created_at : Time.now.utc)

  for post in @posts
    feed.entry(post) do |entry|
      entry.title(post.title)
      markdown = BlueCloth.new(post.body)
      entry.content(markdown.to_html, :type => 'html')

      entry.author do |author|
        author.name("Steve Klabnik")
        author.email("steve@steveklabnik.com")
      end
    end
  end
end

