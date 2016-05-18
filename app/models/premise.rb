class Premise < ActiveRecord::Base
	belongs_to :argument
	belongs_to :parent_premise, class_name: "Premise", foreign_key: "parent_premise_id"	
  has_many :sub_premises, class_name: "Premise", foreign_key: "parent_premise_id", dependent: :destroy

end
