class Sluggifier
  def self.generate(title, all_slugs=[])
    slug = title.parameterize
    while self.conflict?(slug,all_slugs)
      slug = self.next(slug, all_slugs)
    end
    slug
  end

  def self.next(slug,all_slugs)
    sequence = self.conflict(slug,all_slugs).split('-')[1].to_i
    next_sequence = sequence == 0 ? 2 : sequence.next
    "#{slug.gsub(/(\-\d+)/,'')}-#{next_sequence}"
  end

  def self.conflict?(slug,all_slugs)
    !! self.conflict(slug,all_slugs)
  end

  def self.conflict(slug, all_slugs)
    all_slugs.select { |s| s == slug }.first
  end

end
