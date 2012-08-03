class User < ActiveRecord::Base
  attr_accessible :avatar, :description, :geo, :language, :last_mention_at, :location, :name, :postings, :profile, :real_name, :subscribers, :subscriptions, :user_id, :utc
end
