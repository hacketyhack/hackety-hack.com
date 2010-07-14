Factory.define :discussion do |t|

end
Factory.define :discussion_with_reply, :parent => :discussion do |t|
	t.replies {|r| [Factory(:reply)] }
end

Factory.define :reply do |r|
	r.body "I'm here to help!"
end
