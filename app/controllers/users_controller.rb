class UserController < ApplicationController

	def index
		@user1 = User.find params["id1"]
		@influence1 = @user1.previous_influence
	  	@influences1 = @user1.influences 

		@user2 = User.find params["id2"]
		@influence2 = @user2.previous_influence
	  	@influences2 = @user2.influences 


	  	@dates = dates_for_axis(@influences1)
	end


	def show
	  	@user = User.find params["id"]
	  	@influence = @user.previous_influence
	  	@influences = @user.influences 
	  	@dates = dates_for_axis(@influences)
	end

	def dates_for_axis influences
		d = ""
		size = influences.size
		d += "|" + influences[0].date.strftime("%d %b")
		d += "|" + influences[size/2].date.strftime("%d %b")
		d += "|" + influences[size-1].date.strftime("%d %b")
		d
	end

end
