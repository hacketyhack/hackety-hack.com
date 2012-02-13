require 'faker'

users = (0..5).to_a.collect do
  username = Faker::Internet.user_name
  user = User.create!(:username => username,
               :email => "#{username}@example.com",
               :password => (0...50).map{ ('a'..'z').to_a[rand(26)] }.join[0,12]
              )
  user
end

titles = [
%Q{Variables?},
%Q{What is Rails?},
%Q{Shoes help!},
%Q{Other programs?},
%Q{Reading list question...}]

questions = []
questions << %Q{Hello! I have a question! How come I can do this:
    a = 5
a = "hello"

Shouldn't that not work? Why can a be five and then a String?
}
questions << %Q{What is 'ruby on rails?' I've seen stuff about it when I google for Ruby.
}
questions << %Q{I have a program that looks like this:

    edit_line
    button "Repeat" do
      alert("You said '#{??}'")
    end

What do I do for the ??s?
}
questions << %Q{Does anyone have some programs to share?
}
questions << %Q{I've done all the Lessons! What should I check out next?
}

answers = []
answers << [%Q{Ruby is really flexible, it doesn't care what kind of thing your variables are! Don't worry about it.}]
answers << [%Q{It's a way to make websites with Ruby.}]
answers << [%Q{Try this:

    line = edit_line

and then

    alert("You said '\#{line.text}'")}, %Q{Hmm, I think you need a variable...}]
answers << [%Q{Check out [the programs page](/programs).}]
answers << [%Q{I like [_why's poignant guide to ruby](http://mislav.uniqpath.com/poignant-guide/).},
            %Q{Check out [Learn To Program](http://pine.fm/LearnToProgram/)!!!},
            %Q{There's a bunch of things [on Google](http://www.google.com/search?client=safari&rls=en&q=ruby+tutorial&ie=UTF-8&oe=UTF-8), explore them and try a bunch!},
            %Q{I love [Try Ruby](http://tryruby.org).}]

5.times do |i|
  question = Question.new(
   :title => titles[i],
   :description => questions[i]
  )
  question.user = users[i]
  question.save!
  answers[i].collect! do |answer|
    answer = Answer.new(:description => answer)
    answer.question = question
    answer.user = users[(i + 1) % 5]
    answer.save
    answer
  end
  question.solution_id = answers[i].first.id
  question.save!
  questions[i] = question
end

program_code = "
Turtle.draw do
  background maroon
  pencolor honeydew
  450.times do
    forward 100
    turnright 70
  end
end
"

5.times do |i|
  program = Program.new(:author_username => users[i].username,
                        :title => Faker::Lorem.sentence,
                        :description => Faker::Lorem.sentences.join(" "),
                        :source_code => program_code)
  program.save!
end

