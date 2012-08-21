# @author Natalia Garcia Menendez
# @version 1.0
#
# Class that is responsible for receiving requests for the "influence"
class InfluencesController < ApplicationController

	# Method that controls the actions that are intended to show
	def show
	  	@influence = Influence.find params["id"]
	end

end
