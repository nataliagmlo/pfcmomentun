class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :total_audience
      t.integer :total_mentions
      t.integer :total_users
      t.integer :users_with_subscribers

      t.timestamps
    end
  end
end
