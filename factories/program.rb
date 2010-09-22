Factory.sequence :program_title do |n|
  "Program#{n}"
end
Factory.define :program do |p|
  p.title { Factory.next(:program_title) }
  p.code "puts 'hello world'"
end
