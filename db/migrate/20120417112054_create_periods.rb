class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :counter

      t.timestamps
    end
  end
end
