class HomeController < ApplicationController

	def index
		
		calculate_list()
	end

	def show
		@user = nil
		@user = User.name_like params["search"]
		@user = @user.first
	    if @user!=nil
	      redirect_to user_path(@user)
	    else
	    	calculate_list()
	      render :action => :index
	    end
	end

	def calculate_list
		influences_top = Influence.influential_users()
		@top_influences = calculate_users_list(influences_top)

		good_acceleration = Influence.good_acceleration_users()
		@top_accelerations = calculate_users_list(good_acceleration)

		bad_acceleration = Influence.bad_acceleration_users()		
		@worst_accelerations = calculate_users_list(bad_acceleration)

		@user = params[:name]
	end

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
