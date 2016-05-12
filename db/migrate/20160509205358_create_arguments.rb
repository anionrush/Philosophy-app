class CreateArguments < ActiveRecord::Migration
  def change
    create_table :arguments do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
