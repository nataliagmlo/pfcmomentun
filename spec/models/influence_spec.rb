# encoding: utf-8
require_relative '../spec_helper'
require_relative '../../app/models/influence'
require 'time'

describe Influence do
  	
  	describe "#find_previous" do

  		i1 = Influence.new
  		i1.user_id = "999999999"
  		i1.acceleration = 4.25
  		i1.velocity = 5.15
  		i1.audience = 46
  		i1.date = Time.new(2014,"Jun",13, 11, 48, 00, "+00:00")
  		i1.save

  		i2 = Influence.new
  		i2.user_id = "999999999"
  		i2.acceleration = 4.25
  		i2.velocity = 5.15
  		i2.audience = 46
  		i2.date = Time.new(2014,"Jun",13, 15, 48, 00, "+00:00")
  		i2.save

  		i3 = Influence.new
  		i3.user_id = "999999999"
  		i3.acceleration = 4.25
  		i3.velocity = 5.15
  		i3.audience = 46
  		i3.date = Time.new(2014,"Jun",13, 13, 48, 00, "+00:00")
  		i3.save

  		it "find the influence previous" do 

  			i = Influence.find_previous("999999999").first

  			i.date.should == i2.date

  		end

  	end



end
