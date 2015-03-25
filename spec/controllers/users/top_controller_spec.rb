require 'rails_helper'

=begin
describe TopController, 'After login' do
	let(:user) { create(:user) }

	before do
		session[:user_id] = user.id
		session[:last_access_time] = 1.second.ago
	end

	describe '#index' do
		example '通常はusers/top/indexを表示' do
			get :index
			expect(response).to render_template('users/top/index')
		end

		example '停止フラグがセットされたら強制的にログアウト' do
			user.update_column(:suspended, true)
			get :index
			expect(session[:user]).to be_nil
			expect(response).to redirect_to(root_url)
		end

		example 'セッションタイムアウト' do
			session[:last_access_time] = UserBase::TIMEOUT.ago.advance(seconds: -1)
			get :index
			expect(session[:user_id]).to be_nil
			expect(response).to redirect_to(login_url)
		end
	end
end
=end
