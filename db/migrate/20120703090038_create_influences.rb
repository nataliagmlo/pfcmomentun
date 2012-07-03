class CreateInfluences < ActiveRecord::Migration
  def change
    create_table :influences do |t|
      t.float :velocity
      t.float :acceleration
      t.datetime :date
      t.integer :audience

      t.timestamps
    end
  end
end
