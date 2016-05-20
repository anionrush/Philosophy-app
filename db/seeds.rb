# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

list = ["epistemology", "logic", "metaphysics", "ethics", "ancient"]

100.times do
  Argument.create!( title: Faker::Hipster.sentence(10) )
end

arguments = Argument.all

arguments.each do |argument|
	argument.tag_list.add("#{list.sample}")
	argument.save
	argument.reload
end

300.times do
	Premise.create!(
		argument: arguments.sample,
		body: Faker::Hipster.sentence(10),
		sub: false
		)
end

300.times do 
	Premise.create!(
		parent_premise: Premise.all.sample,
		body: Faker::Hipster.sentence(10),
		sub: false )
end


500.times do 
	Premise.create!(
		parent_premise: Premise.where(argument_id: nil).sample,
		body: Faker::Hipster.sentence(10),
		sub: false )
end




puts "#{Argument.count} arguments created"
puts "#{Premise.count} premises created"
