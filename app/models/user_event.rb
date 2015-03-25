class UserEvent < ActiveRecord::Base
	self.inheritance_column = nil

	belongs_to :user, class_name: 'User', foreign_key: 'user_id'
	alias_attribute :occurred_at, :created_at

	DESCRIPTIONS = {
		logged_in: 'Login',
		logged_out: 'Logout',
		rejected: 'Reject login'
	}

	def description
		DESCRIPTIONS[type.to_sym]
	end
end
