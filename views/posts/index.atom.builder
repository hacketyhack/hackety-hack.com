xml.rss :version => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do 
    xml.send(:"atom:link", :href => "http://feeds.feedburner.com/HacketyHack", :rel => "self", :type => "application/rss+xml")
    xml.title "Hackety Hack: Blog"
    xml.link 'http://hackety-hack.com'
    xml.description "The official blog of the little coder's starter kit."
    xml.language 'en'
    xml.pubDate @posts.first.created_at.to_s(:rfc822)
    xml.lastBuildDate @posts.first.created_at.to_s(:rfc822)
    
    @posts.each do  |post|
      xml.item do
        xml.title post.title
        xml.content post.body
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link "http://hackety-hack.com/posts/#{post.slug}"
        xml.guid({:isPermaLink => "false"}, "http://hackety-hack.com/posts/#{post.slug}")
      end
    end
  end
end
