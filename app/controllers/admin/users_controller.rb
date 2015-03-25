class Admin::UsersController < Admin::Base

	def index
		@users = User.order(:family_name_kana, :given_name_kana)
	end

	def show
		user = User.find(params[:id])
		redirect_to [ :edit, :admin, user ]
	end

	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash.notice = 'Completion of registration'
			redirect_to :admin_users
		else
			render action: 'new'
		end
	end

	def update
		@user = User.find(params[:id])
		@user.assign_attributes(user_params)
		if @user.save
			flash.notice = 'Updated account'
			redirect_to :admin_users
		else
			render action: 'edit'
		end
	end

	def destroy
		user = User.find(params[:id])
		user.destroy!
		flash.notice = 'Deleted account'
		redirect_to :admin_users
	end

	private
	def user_params
		params.require(:user).permit(
			:email, :password, :family_name, :given_name,
			:family_name_kana, :given_name_kana,
			:start_date, :end_date, :suspended
		)
	end
end
