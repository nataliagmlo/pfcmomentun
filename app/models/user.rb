# @author Natalia Garcia Menendez
# @version 1.0
#
# Class that represents all the data can be stored in a user
class User < ActiveRecord::Base
  attr_accessible :avatar, :description, :geo, :language, :last_mention_at, :location, :name, :postings, :profile, :real_name, :subscribers, :subscriptions, :user_id, :utc

  def to_s
    s = "User:"
    s += "\n\tuser_id: " + user_id.to_s
    s += "\n\tname: " + name.to_s
    s += "\n\treal_name: " + real_name.to_s 
    s += "\n\tsubscribers: " + subscribers.to_s
    s += "\n\tsubscriptions: " + subscriptions.to_s
    s += "\n\tlast_mention_at: " + last_mention_at.to_s if last_mention_at!=nil
  end
end
