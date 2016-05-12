class AddArgumentToPremises < ActiveRecord::Migration
  def change
    add_reference :premises, :argument, index: true, foreign_key: true
  end
end
