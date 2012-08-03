# encoding: utf-8
require_relative '../spec_helper'
require_relative '../../app/models/period'
require 'time'


describe Period do

	describe "#find" do
		date_tweet = "Wed Jun 13 12:08:40 +0000 2012"
  
		y = date_tweet[26,4]
		m = date_tweet[4,3]
		d = date_tweet[8,2]
		h = date_tweet[11,2] 
		mn = date_tweet[14,2]
		s = date_tweet[17,2]
		z = date_tweet[20,3] + ":" + date_tweet[23,2]

		y = y.to_i
	    d= d.to_i
	    h= h.to_i
	    mn= mn.to_i
		s= s.to_i

		t1 = Time.new(y,m,d, h, 00, 00, z)
		t1 = t1 - 6.hour
		t2 = Time.new(y,m,d, h, 59, 59, z) 
		t2 = t2 - 6.hour	

		p = Period.new(:start_time => t1 , :end_time => t2 )
		p.save


		t1 = t1 + 1.hour
		t2 = t2 + 1.hour
		pf = Period.new(:start_time => t1 , :end_time => t2 )
		pf.save

		it "find the period previous" do 
			previous_hour = Time.new(y,m,d, h, mn, s, z) - 2.hour
			p= Period.find_previous(previous_hour)
			if p.first == nil
				puts "find another previous"
				previous_hour = previous_hour - 1.hour
				p = Period.find_another_previous(previous_hour)
			end
			p1 = p.first
			puts p1.start_time == pf.start_time
			puts p1.end_time == pf.end_time
		end
	end

end
