# @author Natalia Garcia Menendez
# @version 1.0
#
# Class that represents all the data can be stored in a user
class User < ActiveRecord::Base
  attr_accessible :avatar, :description, :geo, :language, :last_mention_at, :location, :name, :postings, :profile, :real_name, :subscribers, :subscriptions, :user_id, :utc
  has_many :influences

  scope :name_like, lambda { |name| 
    {:conditions => ["lower(name) = ?", name.downcase]}
  }

  def previous_influence
    i = Influence.find_previous(id).first
    i
  end

  def to_s
    s = "User:"
    s += "\n\tuser_id: " + user_id.to_s
    s += "\n\tname: " + name.to_s
    s += "\n\treal_name: " + real_name.to_s 
    s += "\n\tsubscribers: " + subscribers.to_s
    s += "\n\tsubscriptions: " + subscriptions.to_s
    s += "\n\tlast_mention_at: " + last_mention_at.to_s if last_mention_at!=nil
    s
  end

  def equals user
    return id == user.id
  end
end
