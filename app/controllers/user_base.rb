class UserBase < ApplicationController
	before_action :authorize
	before_action :check_account
	before_action :check_timeout

	private
	def current_user
		if session[:user_id]
			@current_user ||=
				User.find_by(id: session[:user_id])
		end
	end

	helper_method :current_user

	def authorize
		unless current_user
			flash.alert = 'Please login.'
			redirect_to :login
		end
	end

	def check_account
		if current_user && !current_user.active?
			session.delete(:user_id)
			flash.alert = 'アカウントが無効になりました'
			redirect_to :root
		end
	end

	TIMEOUT = 60.minutes

	def check_timeout
		if current_user
			if session[:last_access_time] >= TIMEOUT.ago
				session[:last_access_time] = Time.current
			else
				session.delete(:user_id)
				flash.alert = 'The session was timeout.'
				redirect_to :login
			end
		end
	end
end

