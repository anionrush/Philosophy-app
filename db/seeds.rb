# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

list = ["epistemology", "logic", "metaphysics", "ethics", "ancient"]

100.times do
  Argument.create!( title: "Example Argument Title Placeholder Text" )
end

arguments = Argument.all

arguments.each do |argument|
	argument.tag_list.add("#{list.sample}")
	argument.save
	argument.reload
	3.times do
		Premise.create!(
		argument: argument,
		body: Faker::Hipster.sentence(10),
		sub: false
		)
	end
end

3.times do
	arguments.each do |argument|
		argument.premises.each do |premise|
			Premise.create!(
				parent_premise: premise,
				body: Faker::Hipster.sentence(10),
				sub: false
			)
		end
	end
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
