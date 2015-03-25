class UsersController < UserBase
	def index
		render action: 'index'
	end

	def show
		@user = current_user
	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user
		@user.assign_attributes(user_params)
		if @user.save
			flash.notice = 'Updated Account'
			redirect_to :account
		else
			render action: 'edit'
		end
	end

	private
	def user_params
		params.require(:user).permit(
			:email, :family_name, :given_name,
			:family_name_kana, :given_name_kana
		)
	end
end
