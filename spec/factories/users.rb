FactoryGirl.define do
	factory :user do
		sequence(:email) { |n| "user#{n}@example.com" }
		family_name '山田'
		given_name '太郎'
		family_name_kana 'ヤマダ'
		given_name_kana 'タロウ'
		password 'pw'
		start_date { Date.yesterday }
		end_date nil
		suspended false
	end
end

