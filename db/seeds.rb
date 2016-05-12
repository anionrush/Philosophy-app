# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

list = ["epistemology", "logic", "metaphysics", "ethics", "ancient"]

5.times do
  Argument.create!( title: "This is the title for blah" )
end

arguments = Argument.all

arguments.each do |argument|
	argument.tag_list.add("#{list.sample}")
	argument.save
	argument.reload
	puts argument.tags
end

3.times do
	Premise.create!(
		argument: arguments.sample,
		body: "a;ldsfa lkajsdhf ip lkavlksjhdf owiur m asldf ajkd lsdfsd",
		sub: false
		)
end

premises = Premise.all

10.times do 
	Premise.create!(
		parent_premise: premises.sample,
		body: "this is a sub premise blah blah blah blah",
		sub: false )
end

p = Premise.first.sub_premises.first

5.times do 
	Premise.create!(
		parent_premise: p,
		body: "this is a sub premise blah blah blah blah",
		sub: false )
end

p1 = p.sub_premises.first

5.times do 
	Premise.create!(
		parent_premise: p1,
		body: "this is a sub premise blah blah blah blah",
		sub: false )
end




puts "#{Argument.count} arguments created"
puts "#{Premise.count} premises created"
