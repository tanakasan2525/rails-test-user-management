require 'rails_helper'

describe UsersController do
	describe '#udpate' do
		let(:params_hash) { attributes_for(:user) }
		let(:user) { create(:user) }

		before do
			session[:user_id] = user.id
			session[:last_access_time] = 1.second.ago
		end

		example 'email属性を変更する' do
			params_hash.merge!(email: 'test@example.com')
			patch :update, id: user.id, user: params_hash
			user.reload
			expect(user.email).to eq('test@example.com')
		end
		
		example '例外ActionController::ParameterMissingが発生(String Parameters)' do
			bypass_rescue
			expect { patch :update, id: user.id }.
				to raise_error(ActionController::ParameterMissing)
		end

		example 'end_dateの値は書き換え不可' do
			params_hash.merge!(end_date: Date.tomorrow)
			expect {
				patch :update, id: user.id, user: params_hash
			}.not_to change { user.end_date }
		end
	end
end

