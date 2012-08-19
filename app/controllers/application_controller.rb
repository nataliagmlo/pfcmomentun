class ApplicationController < ActionController::Base

	def index
	@user = User.name_like
end

  protect_from_forgery
end
