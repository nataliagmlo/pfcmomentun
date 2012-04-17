class CreateVelocities < ActiveRecord::Migration
  def change
    create_table :velocities do |t|
      t.float :average_velocity
      t.float :average_acceleration
      t.timestamp :date
      t.integer :audience

      t.timestamps
    end
  end
end
