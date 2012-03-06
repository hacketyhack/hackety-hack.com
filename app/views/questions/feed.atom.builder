atom_feed :language => 'en-US' do |feed|
  feed.title @title
  feed.updated @updated

  @questions.each do |item|
    next if item.created_at.blank?

    feed.entry item do |entry|
      entry.url questions_url(item)
      entry.title item.title
      entry.content item.description, :type => 'html'
      entry.updated(item.created_at.strftime("%Y-%m-%dT%H:%M:%SZ"))
      entry.author item.user
    end
  end
end

