class Admin::Base < ApplicationController
	before_action :authorize

	private
	def current_administrator
		if session[:user_id]
			@current_administrator ||=
				User.find_by(id: session[:user_id])
		end
	end

	helper_method :current_administrator

	def authorize
		unless current_administrator
			flash.alert = 'Please login as administrator'
			redirect_to :login
		end
	end
end

