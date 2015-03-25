module FeaturesSpecHelper
	def switch_namespace(namespace)
		config = Rails.application.config.baukins
		Capybara.app_host = 'http://' + config[namespace][:host]
	end

	def login_as_user(user, password = 'pw')
		visit login_path
		within('#login-form') do
			fill_in 'Email', with: user.email
			fill_in 'Password', with: password
			click_button 'Login'
		end
	end
end
