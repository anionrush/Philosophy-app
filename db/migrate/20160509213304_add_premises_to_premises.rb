class AddPremisesToPremises < ActiveRecord::Migration
  def change
  	add_column :premises, :parent_premise_id, :integer
  end
end
