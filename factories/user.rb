Factory.sequence :email do |n|
	"user#{n}@example.com"
end

Factory.define :user do |u|
	u.username "steve"
	u.email { Factory.next(:email) }
	u.password "foobar"
	u.password_confirmation {|user| user.password }
	u.admin false
end

Factory.define :admin, :parent => :user do |u|
	u.admin true
end
