xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Questions"
    xml.link questions_url

    for question in @questions
       xml.item do
         xml.title question.title
         xml.description question.description
         xml.pubDate question.created_at.to_s(:rfc822)
         xml.link questions_url(question)
         xml.guid questions_url(question)
       end
    end
  end
end
