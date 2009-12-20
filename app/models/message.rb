class Message < ActiveRecord::Base
	belongs_to :sender, :class_name => "User"
	belongs_to :recipient, :class_name => "User"

  after_save :from

  attr_accessor :from

  def from
    @from = @attributes["from"] = sender.username unless sender.nil?
  end

  def after_initialize
    from
  end

end
