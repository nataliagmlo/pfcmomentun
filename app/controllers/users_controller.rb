# @author Natalia Garcia Menendez
# @version 1.0
#
# Class that is responsible for receiving requests for the "user"
class UsersController < ApplicationController

	# Method that controls the actions that are intended to index
	def index
		@user1 = User.find params["id1"]
		@influence1 = @user1.previous_influence
	  	@influences1 = @user1.influences 

		@user2 = User.find params["id2"]
		@influence2 = @user2.previous_influence
	  	@influences2 = @user2.influences 
	  	
	  	merge_influences = @influences1 + @influences2
	  	@dates = dates_for_axis(merge_influences)
	  	@axis_y_values = axis_values(merge_influences)
	  	@axis_y_labels = axis_labels(@axis_y_values)
	end

	# Method that controls the actions that are intended to show
	def show
	  	@user = User.find params["id"]
	  	@influence = @user.previous_influence
	  	@influences = @user.influences 

	  	@dates = dates_for_axis(@influences)
	  	@axis_y_values = axis_values(@influences)
	  	@axis_y_labels = axis_labels(@axis_y_values)
	end

	# Helper method to calculate the name of axis labels "y"
	def axis_labels axis_values
		l = ""
		dist = (axis_values[1].to_i - axis_values[0].to_i)/5.0
		valor = axis_values[0].to_i
		for num in (1..6)
			l += "|" + (format "%.2f", valor).to_s
			valor += dist
		end
		l

	end

	# Helper method to calculate the value of axis labels "y"
	def axis_values influences
		min = influences[0].velocity
		max = influences[0].velocity

		influences.each do |influence| 
			if influence.velocity < min
				min = influence.velocity
			end
			if influence.velocity > max
				max = influence.velocity
			end

		end
		v = []
		min = (min*100).floor

		v[0] = min.to_s 
		v[1] = ((max*100).ceil).to_s
		v
	end

	# Helper method to calculate the name of axis labels "x"
	def dates_for_axis influences
		min = influences[0].date
		max = influences[0].date

		influences.each do |influence| 
			if influence.date < min
				min = influence.date
			end
			if influence.date > max
				max = influence.date
			end
		end
		hours = ((max - min)/3600)/3

		media = min + hours.hour


		d = ""
		size = influences.size
		d += "|" + min.strftime("%d %b %H:%M")
		d += "|" + media.strftime("%d %b %H:%M")
		d += "|" + (media + hours.hour).strftime("%d %b %H:%M")
		d += "|" + max.strftime("%d %b %H:%M")
		d
	end

end
