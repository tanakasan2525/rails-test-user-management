require 'rails_helper'

RSpec.describe User, :type => :model do
	describe '#password=' do
		example '文字列を与えると、hashed_passwordは長さ60の文字列になる' do
			user = User.new
			user.password = 'teamdev'
			expect(user.hashed_password).to be_kind_of(String)
			expect(user.hashed_password.size).to eq(60)
		end

		example 'nilを与えると、hashed_passwordはnilになる' do
			user = User.new(hashed_password: 'x')
			user.password = nil
			expect(user.hashed_password).to be_nil
		end
	end

	describe '値の正規化' do
		example 'email前後の空白を除去' do
			user = create(:user, email: 'test@example.com ')
			expect(user.email).to eq('test@example.com')
		end

		example 'emailに含まれる全角英数字記号を半角に変換' do
			user = create(:user, email: 'ｔeｓｔ＠eｘaｍｐｌe.ｃoｍ')
			expect(user.email).to eq('test@example.com')
		end

		example 'email前後の全角スペースを除去' do
			user = create(:user, email: "\u{3000}test@example.com\u{3000}")
			expect(user.email).to eq('test@example.com')
		end

		example 'family_name_kanaに含まれるひらがなをカタカナに変換' do
			user = create(:user, family_name_kana: 'てすと')
			expect(user.family_name_kana).to eq('テスト')
		end

		example 'family_name_kanaに含まれる半角カナを全角カナに変換' do
			user = create(:user, family_name_kana: 'ﾃｽﾄ')
			expect(user.family_name_kana).to eq('テスト')
		end
	end

	describe 'バリデーション' do
		example '@を2個含むemailは無効' do
			user = build(:user, email: 'test@@example.com')
			expect(user).not_to be_valid
		end

		example '漢字を含むfamily_name_kanaは無効' do
			user = build(:user, family_name_kana: '試験')
			expect(user).not_to be_valid
		end

		example '長音符を含むfamily_name_kanaは有効' do
			user = build(:user, family_name_kana: 'エリー')
			expect(user).to be_valid
		end

		example '他のユーザーのメールアドレスと重複したemailは無効' do
			user1 = create(:user)
			user2 = build(:user, email: user1.email)
			expect(user2).not_to be_valid
		end
	end
end
