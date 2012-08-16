class HomeController < ApplicationController

	def index
		t = Time.now
		t = t.to_a
		t = Time.new(t[5],t[4],t[3], t[2], 0, 0, "+00:00")
		t = t - 1.hour
		@influences = Influence.influential_users(t)
	end

	def show

	end

end
