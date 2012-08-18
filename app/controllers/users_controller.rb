class UsersController < ApplicationController

	def index
		@users = User.all
	end


	def show
	  	@user = User.find params["id"]
	  	@influence = @user.previous_influence
	  	@influences = @user.influences 
	end

end
