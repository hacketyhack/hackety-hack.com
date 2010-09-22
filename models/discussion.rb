#this model represents a single discussion in the forum
class Discussion
  #we need to keep discussions in the database!
  include MongoMapper::Document

  #the title of a discussion
  key :title, String

  #the person who created this discussion
  key :author, String
  key :author_email, String

  #the text of a discussion
  key :body, String

  #this is the forum that it's in.
  key :forum, String

  #these are all the replies people make
  many :replies

  #this is the slug for the url
  key :slug, String

  timestamps!

  before_save :make_slug
  validate_on_create :author_check

  #THIS IS NOT DRY!!!!
  #These two functions are also in helpers.rb.
  #I'm not sure of the best way to combine them. Anyone want to write a patch?

  #gives a printable forum name from a slug
  def forum_name
    case forum
    when 'learning_ruby'
      "Learning Ruby"
    when 'hackety_help'
      "Hackety Help"
    when 'clubhouse'
      "The Clubhouse"
    end
  end

  #gives a description for a forum
  def forum_description
    case forum
    when 'learning_ruby'
        "A place to learn about the Ruby programming language."
    when 'hackety_help'
        "Have a question about Hackety? You're in the right place!"
    when 'clubhouse'
        "A place to talk to other Hackers about anything you'd like to talk about."
    end
  end

  private
  def make_slug
    self.slug = self.title.to_slug
  end

  def author_check
    if author.nil?
      errors.add(:author, "Someone must have started this discussion!")
    end
  end

end
