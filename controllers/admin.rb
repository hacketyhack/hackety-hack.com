#This is the 'admins' controller

# Show how many users there are
get '/admin' do
	admin_only!
	#get usercount
	@usercount = Hacker.all.length
	today = Date.today
	@newusers = Hacker.all(:created_at => {'$gt' => today.to_time, '$lt' => (today + 1.day).to_time}).length
	@newusernames = Hacker.all(:created_at => {'$gt' => today.to_time, '$lt' => (today + 1.day).to_time})
	@forumposts = Discussion.all(:created_at => {'$gt' => today.to_time, '$lt' => (today + 1.day).to_time}).length
	@postlinks = Discussion.all(:created_at => {'$gt' => today.to_time, '$lt' => (today + 1.day).to_time})	
	@forumreplies = Discussion.all(:updated_at => {'$gt' => today.to_time, '$lt' => (today + 1.day).to_time}).length
 
	haml :"admin/index"
end

