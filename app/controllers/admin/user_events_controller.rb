class Admin::UserEventsController < Admin::Base
	def index
		if params[:user_id]
			@user = User.find(params[:user_id])
			@events = @user.events
		else
			@events = UserEvent
		end
		@events = @events.order(occurred_at: :desc)
			.includes(:user).page(params[:page])
	end
end
