module PremisesHelper

	#take's main premises and puts them in first order ol
	def wrap_arg(argument)
		res = "<ol>"
		argument.premises.each do |premise|
			#adds dropdown icon if premise has subpremises
			if premise.sub_premises.count != 0
				res << "<li> #{premise.body} 
				<button class='glyphicon glyphicon-chevron-down' data-toggle='collapse' data-target='#coll#{premise.id}'></button> 
				#{premise_helper(premise)}  </li> "
			#doesn't add dropdown icon if premise doesn't have subpremises
			else 
				res << "<li> #{premise.body} #{premise_helper(premise)}  </li> "
			end

		end
		res << "</ol>"

		res.html_safe
	end

	#nested inside of main premise ol
	def premise_helper(premise)

		res = "<ol id=coll#{premise.id} class='collapse'>"

		if premise.sub_premises.count != 0
			premise.sub_premises.each do |sub_premise|
				if sub_premise.sub_premises.count != 0
					res << "<li> #{sub_premise.body} <button class='glyphicon glyphicon-chevron-down' data-toggle='collapse' data-target='#coll#{sub_premise.id}'></button> </li> #{premise_helper(sub_premise)}"
				else
					res << "<li> #{sub_premise.body} </li> #{premise_helper(sub_premise)}"
				end			
			end
		end

		res << "</ol>"

		res
	end



	def wrap_arg_edit(argument)

		res = "<ol>"

		argument.premises.each do |premise|
			#add modal crud to main premise
			res << " <a href='' data-toggle='modal' data-target='#modal-#{premise.id}'> 
								<li style='font-size:18px;'>  
									<p> #{premise.body} </p>
									<div class='modal' id='modal-#{premise.id}'>
    								<div class='modal-dialog'>
      								<div class='modal-content'>
        								<div class='modal-header'>
          								<button type='button' class='close' data-dismiss='modal'> &times; </button>
          								<h3 class='modal-title'>#{premise.body}</h3>
			                    <a href= 'premises/#{premise.id}/premises/new'> <button class='btn btn-lg btn-success'>Add Subpremise</button> </a>
													<a href= 'premises/#{premise.id}/edit'><button class='btn btn-lg btn-warning'>Edit Premise</button> </a>
													<a href= 'premises/#{premise.id}' data-confirm='Are you sure you want to delete this premise?' data-method='delete' rel='nofollow'><button class='btn btn-lg btn-danger'>Delete Premise</button> </a>
        								</div>
								      </div>
								    </div>
									</div>   #{premise_helper_edit(premise)}  </li> </a> " 
		end
		res << "</ol>"

		res.html_safe
	end


	def premise_helper_edit(premise)

		res = "<ol>"

		if premise.sub_premises.count != 0
			premise.sub_premises.each do |sub_premise|
				#add modal crud to subpremise
				res << "<a href='' data-toggle='modal' data-target='#submodal-#{sub_premise.id}'> 
									<li style='font-size:18px;'> 
										<p> #{sub_premise.body} </p> 
									</li> 
								</a> 
								<div class='modal' id='submodal-#{sub_premise.id}'>
    							<div class='modal-dialog'>
      							<div class='modal-content'>
        							<div class='modal-header'>
          							<button type='button' class='close' data-dismiss='modal'> &times; </button>
          							<h3 class='modal-title'> #{sub_premise.body}</h3>
                    		<a href= 'premises/#{sub_premise.id}/premises/new'> <button class='btn btn-lg btn-success'>Add Subpremise</button> </a>
												<a href= 'premises/#{sub_premise.id}/edit'><button class='btn btn-lg btn-warning'>Edit Premise</button> </a>
												<a href= 'premises/#{sub_premise.id}' data-confirm='Are you sure you want to delete this premise?' data-method='delete' rel='nofollow'><button class='btn btn-lg btn-danger'>Delete Premise</button> </a>
        							</div>
      							</div>
    							</div>
								</div>   #{premise_helper_edit(sub_premise)}"
			end
		end

		res << "</ol>"

		res
	end

end
