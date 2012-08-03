class AddUserIdToInfluence < ActiveRecord::Migration
  def change
    add_column :influences, :user_id, :integer
  end
end
