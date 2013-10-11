Fabricator(:message) do
	email(count: 1) {"proof@example.com" }
	subject:"Hackety-hack email"
	body:"This is an email from hackety-hack.com"
end

Fabricator(:diffusion, from: :message) do
	email(count: 5) { |i| "proof#{i}@example.com" }
	subject:"Hackety-hack email"	
	body:"This is an email from hackety-hack.com"
end
