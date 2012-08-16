# @author Natalia Garcia Menendez
# @version 1.0
#
# Class that represents the estimated impact on a date for a user 
class Influence < ActiveRecord::Base
  attr_accessible :acceleration, :audience, :date, :velocity
  belongs_to :user

  scope :find_previous, lambda { |user|
    {:conditions => ["user_id = ?", user], :order => "date desc"}
  }

  scope :influential_users, lambda { |time|
    {:conditions => ["date >= ?", time], :order => "velocity desc"}
  }

  def to_s
    s = "Influence:"
    s += "\n\tuser_id: " + user_id.to_s
    s += "\n\tdate: " + date.to_s
    s += "\n\tacceleration: " + acceleration.to_s 
    s += "\n\tvelocity: " + velocity.to_s
    s += "\n\taudience: " + audience.to_s 
    s
  end
end
