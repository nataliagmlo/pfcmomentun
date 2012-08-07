# @author Natalia Garcia Menendez
# @version 1.0
#
# Class that represents the estimated impact on a date for a user 
class Influence < ActiveRecord::Base
  attr_accessible :acceleration, :audience, :date, :velocity, :user_id

  def to_s
    s = "Influence:"
    s += "\n\tuser_id: " + user_id.to_s
    s += "\n\tdate: " + date.to_s
    s += "\n\tacceleration: " + acceleration.to_s 
    s += "\n\tvelocity: " + velocity.to_s
    s += "\n\taudience: " + audience.to_s 
  end
end
