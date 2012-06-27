class CreatePeriods < ActiveRecord::Migration
  def change
	drop_table :periods
    create_table :periods do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :total_audience
      t.float :acceleration
      t.float :velocity
      t.integer :total_mentions
      t.string :mean_time_between_mentions
      t.string :float

      t.timestamps
    end
  end
end
