class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	layout :set_layout

	class Forbidden < ActionController::ActionControllerError; end
	class IpAddressRejected < ActionController::ActionControllerError; end

	include ErrorHandlers if Rails.env.production?

	private
	def set_layout
		if params[:controller].match(%r{\A(admin|user)/})
			Regexp.last_match[1]
		else
			'user'
		end
	end
end

