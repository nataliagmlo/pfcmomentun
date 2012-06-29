class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :real_name
      t.string :user_id
      t.string :language
      t.string :utc
      t.string :geo
      t.string :description
      t.string :avatar
      t.string :location
      t.integer :subscribers
      t.integer :subscriptions
      t.integer :postings
      t.string :profile

      t.timestamps
    end
  end
end
