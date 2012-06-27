class User < ActiveRecord::Base
  attr_accessible :avatar, :description, :geo, :language, :location, :name, :postings, :profile, :real_name, :subscribers, :subscriptions, :user_id, :utc
end
