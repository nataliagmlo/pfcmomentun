class CreateVelocities < ActiveRecord::Migration
  def change
	drop_table :velocities
    create_table :velocities do |t|
      t.float :velocity
      t.float :acceleration
      t.datetime :date
      t.integer :audience

      t.timestamps
    end
  end
end
