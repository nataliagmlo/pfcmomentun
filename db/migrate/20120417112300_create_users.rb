class CreateUsers < ActiveRecord::Migration
  def change
    drop_table :users
    create_table :users do |t|
      t.string :status_id
      t.string :name

      t.timestamps
    end
  end
end
