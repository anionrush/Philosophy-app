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



	def wrap_arg_edit(argument)

		res = "<ol>"

		argument.premises.each do |premise|
			res << " <a href='' data-toggle='modal' data-target='#modal-#{premise.id}'> <li style='font-size:18px;'>  <p> #{premise.body} </p>
	<div class='modal' id='modal-#{premise.id}'>
    <div class='modal-dialog'>
      <div class='modal-content'>
        <div class='modal-header'>
          <button type='button' class='close' data-dismiss='modal'> &times; </button>
          <h3 class='modal-title'>#{premise.body}</h3>
                    <a href= 'premises/#{premise.id}/premises/new'> <button class='btn btn-lg btn-success'>Add Subpremise</button> </a>
<button class='btn btn-lg btn-warning'>Edit Premise</button>
<button class='btn btn-lg btn-danger'>Delete Premise</button>
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
				res << "<a href='' data-toggle='modal' data-target='#submodal-#{sub_premise.id}'> <li style='font-size:18px;'> <p> #{sub_premise.body} </p> </li> </a> 
				<div class='modal' id='submodal-#{sub_premise.id}'>
    <div class='modal-dialog'>
      <div class='modal-content'>
        <div class='modal-header'>
          <button type='button' class='close' data-dismiss='modal'> &times; </button>
          <h3 class='modal-title'> This is the heading #{sub_premise.id}</h3>
                    <a href= 'premises/#{sub_premise.id}/premises/new'> <button class='btn btn-lg btn-success'>Add Subpremise</button> </a>
<button class='btn btn-lg btn-warning'>Edit Premise</button>
<button class='btn btn-lg btn-danger'>Delete Premise</button>
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
