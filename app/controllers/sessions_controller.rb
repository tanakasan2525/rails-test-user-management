class SessionsController < UserBase 
	skip_before_action :authorize

	def new
		if current_user
			redirect_to :root
		else
			@form = LoginForm.new
			render action: 'new'
		end
	end

	def create
		@form = LoginForm.new(params[:login_form])
		if @form.email.present?
			user = User.find_by(email_for_index: @form.email.downcase)
		end
		if Authenticator.new(user).authenticate(@form.password)
			if user.suspended?
				user.events.create!(type: 'rejected')
				flash.now.alert = 'Your account is freezed!'
				render action: 'new'
			else
				session[:user_id] = user.id
				session[:last_access_time] = Time.current
				user.events.create!(type: 'logged_in')
				flash.notice = 'Logined'
				redirect_to :root
			end
		else
			flash.now.alert = 'The email or password you entered is incorrect.'
			render action: 'new'
		end
	end

	def destroy
		if current_user
			current_user.events.create!(type: 'logged_out')
		end
		session.delete(:user_id)
		flash.notice = 'Logout'
		redirect_to :root
	end
end
