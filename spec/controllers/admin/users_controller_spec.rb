require 'rails_helper'
require 'spec_helper'

describe Admin::UsersController, 'Before login' do
	it_behaves_like 'a protected admin controller'
end

describe Admin::UsersController do
	let(:params_hash) { attributes_for(:user) }
	let(:user) { create(:user) }

	before do
		session[:user_id] = user.id
	end

	describe '#create' do
		example 'ユーザー一覧ページにリダイレクト' do
			post :create, user: params_hash
			expect(response).to redirect_to(admin_users_url)
		end

		example '例外ActionController::ParameterMissingが発生(Strong Parameters)' do
			bypass_rescue
			expect { post :create }.
				to raise_error(ActionController::ParameterMissing)
		end
	end

	describe '#update' do
		example 'suspendedフラグをセットする' do
			params_hash.merge!(suspended: true)
			patch :update, id: user.id, user: params_hash
			user.reload
			expect(user).to be_suspended
		end

		example 'hashed_passwordの値は書き換え不可' do
			params_hash.delete(:password)
			params_hash.merge!(hashed_password: 'x')
			expect {
				patch :update, id: user.id, user: params_hash
			}.not_to change { user.hashed_password.to_s }
		end
	end
end
