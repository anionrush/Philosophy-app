module PremisesHelper
	def wrap_arg(argument)
		res = "<ol>"
		argument.premises.each do |premise|
			res << "<li> #{premise.body} #{premise_helper(premise)}</li>"
		end
		res << "</ol>"

		res.html_safe
	end

	def premise_helper(premise)
		res = "<ol>"

		if premise.sub_premises.count != 0
			premise.sub_premises.each do |sub_premise|
				res << "<li> #{premise.body} </li> #{premise_helper(sub_premise)}"
			end
		end

		res << "</ol>"

		res
	end

end
