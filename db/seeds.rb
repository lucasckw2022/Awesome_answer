# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
100.times do
  q = Question.create title:      Faker::Company.bs,
                      body:       Faker::Lorem.paragraph,
                      view_count: 0
  10.times do
    random = rand(20)
    if random < 10
      q.answers.create(body: Faker::StarWars.quote)
    else
      q.answers.create(body: Faker::Lorem.paragraph)
    end
  end
end

10.times do
  Category.create(name: Faker::Hacker.adjective)
end

puts Cowsay.say("100!!!!!!")
