class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :total_audience
      t.float :acceleration
      t.float :velocity
      t.integer :total_mentions
      t.float :mean_time_mentions

      t.timestamps
    end
  end
end
