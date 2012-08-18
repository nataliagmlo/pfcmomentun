class InfluencesController < ApplicationController

	def show
	  	@influence = Influence.find params["id"]
	end

end
