atom_feed :language => 'en-US' do |feed|
  feed.title "Hackety Hack Questions"
  feed.updated @updated

  @questions.each do |question|
    feed.entry( question ) do |entry|
      entry.url question_url(question)
      entry.title question.title
      entry.content question.description

      # the strftime is needed to work with Google Reader.
      entry.updated(question.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

      entry.author do |author|
        author.name question.user.username
      end
    end
  end
end