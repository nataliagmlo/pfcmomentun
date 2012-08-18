# @author Natalia Garcia Menendez
# @version 1.0
#
# Class that represents the estimated impact on a date for a user 
class Influence < ActiveRecord::Base
  attr_accessible :acceleration, :audience, :date, :velocity, :user_id
  belongs_to :user

  scope :find_previous, lambda { |user|
    {:conditions => ["user_id = ?", user], :order => "date desc"}
  }

  scope :influential_users, lambda { 
    t = Time.now
    t = t - 1.hour
    {:conditions => ["created_at >= ?", t], :order => "velocity desc"}
  }

  scope :good_acceleration_users, lambda { 
    t = Time.now
    t = t - 1.hour
    {:conditions => ["created_at >= ?", t], :order => "acceleration desc"}
  }

  scope :bad_acceleration_users, lambda { 
    t = Time.now
    t = t - 1.hour
    {:conditions => ["created_at >= ?", t], :order => "acceleration asc"}
  }

  def to_s
    s = "Influence:"
    s += "\n\tuser_id: " + user_id.to_s
    s += "\n\tdate: " + date.to_s
    s += "\n\tacceleration: " + acceleration.to_s 
    s += "\n\tvelocity: " + velocity.to_s
    s += "\n\taudience: " + audience.to_s 
    s += "\n\tcreated_at: " + created_at.to_s
    s
  end
end
