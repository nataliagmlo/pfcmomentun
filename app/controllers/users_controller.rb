# @author Natalia Garcia Menendez
# @version 1.0
#
# Class that is responsible for receiving requests for the "user"
class UsersController < ApplicationController


	# Method that controls the actions that are intended to show
	def show
		@compare = false
	  	calculate_detail_user(params["id"])
	end

	# Method that controls the actions that are intended to compare
	def compare
		@compare = false
		if params["compare_to"] != ""
			@user2 = (User.name_like params["compare_to"]).first

			if @user2 != nil

				@compare = true

				@user1 = User.find params["user_id"]
				@influence1 = @user1.previous_influence
			  	@influences1 = @user1.influences 
				
				@influence2 = @user2.previous_influence
			  	@influences2 = @user2.influences 
			  	
			  	dates_values = dates_for_axis(@influences1)
			  	@dates1 = dates_label_axis(dates_values)
			  	dates_values = dates_for_axis(@influences2)
			  	@dates2 = dates_label_axis(dates_values)


			  	merge_influences = @influences1 + @influences2
			  	@axis_y_values = axis_values(merge_influences)
			  	@axis_y_labels = axis_labels(@axis_y_values)
			else
				calculate_detail_user(params["user_id"])
				@errorCompare = "El usuario '" + params["compare_to"] + "' no existe"
				render :action => :show
			end
		else 
			calculate_detail_user(params["user_id"])
			@errorCompare = "Debes introducir un nombre de usuario"
		    render :action => :show
		end
	end


	# Helper method to find the details of the user with the received id
	def calculate_detail_user ident
		@user = User.find ident
	  	@influence = @user.previous_influence
	  	@influences = @user.influences

	  	dates_values = dates_for_axis(@influences)
	  	@dates = dates_label_axis(dates_values)
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

	# Helper method to calculate the value of axis labels "x"
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

		dates = []

		dates << min 
		dates << media
		dates << max

		dates
	end


	# Helper method to calculate the name of axis labels "x"
	def dates_label_axis dates
		hours = ((dates[2] - dates[0])/3600)/3
		d = ""
		d += "|" + dates[0].strftime("%d/%m/%y %H:%M")
		d += "|" + dates[1].strftime("%d/%m/%y %H:%M")
		d += "|" + (dates[1] + hours.hour).strftime("%d/%m/%y %H:%M")
		d += "|" + dates[2].strftime("%d/%m/%y %H:%M")
		d

	end

end
