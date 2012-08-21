# @author Natalia Garcia Menendez
# @version 1.0
#
# Class that is responsible for receiving requests for the "home"
class HomeController < ApplicationController

	# Method that controls the actions that are intended to index
	def index
		calculate_list()
	end

	# Method that controls the actions that are intended to show
	def show
		@user = nil
		if params["search"] != ""
			@user = User.name_like params["search"]
			@user = @user.first
		    if @user!=nil
		      redirect_to user_path(@user)
		    else
		    	calculate_list()
		    	@error = "El usuario " + params["search"] + " no exite"
		      	render :action => :index
		    end
		else
			calculate_list()
		    @error = "Debes introducir un nombre de usuario"
		    render :action => :index
		end
	end

	# Helper method to load all variables relevant listings
	def calculate_list
		influences_top = Influence.influential_users()
		@top_influences = calculate_users_list(influences_top)

		good_acceleration = Influence.good_acceleration_users()
		@top_accelerations = calculate_users_list(good_acceleration)

		bad_acceleration = Influence.bad_acceleration_users()		
		@worst_accelerations = calculate_users_list(bad_acceleration)

		@user = params[:name]
	end

	# Helper method to calculate the 10 most influential users
	def calculate_users_list influences
		users_list = []
		top = 0
		pos = 0
		while top < 10 and pos < influences.size
			if not user_in(top, influences[pos].user, users_list)
				users_list[top] = influences[pos]
				top += 1
			end
			pos += 1
		end
		users_list
	end

	# Helper method to check whether a user is in an array of users
	def user_in top, user, users
		i = 0
		while i < top
			if users[i].user.equals(user)
				return true
			end
			i += 1
		end 
		return false
	end

end
