Fabricator(:message) do
	email(count: 1) {"proof@example.com" }
	subject:"Hackety-hack email"
	body:"This is an email from hackety-hack.com"
end
