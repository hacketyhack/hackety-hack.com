Factory.sequence :email do |n|
	"user#{n}@example.com"
end

Factory.define :hacker do |u|
	u.username "steve"
	u.email { Factory.next(:email) }
	u.password "foobar"
	u.password_confirmation {|user| user.password }
	u.admin false
end

Factory.define :admin, :parent => :hacker do |u|
	u.admin true
end
