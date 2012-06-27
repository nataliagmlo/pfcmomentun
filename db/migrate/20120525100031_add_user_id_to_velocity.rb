class AddUserIdToVelocity < ActiveRecord::Migration
  def change
    add_column :velocities, :user_id, :integer
  end
end
