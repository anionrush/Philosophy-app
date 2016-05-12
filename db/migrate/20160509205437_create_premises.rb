class CreatePremises < ActiveRecord::Migration
  def change
    create_table :premises do |t|
      t.text :body
      t.boolean :sub

      t.timestamps null: false
    end
  end
end
