User.create!(
	email: 'taro@example.com',
	family_name: '山田',
	given_name: '太郎',
	family_name_kana: 'ヤマダ',
	given_name_kana: 'タロウ',
	password: 'password',
	start_date: Date.today
)

family_names = %w{
	岡崎:オカザキ:okazaki
	古河:フルカワ:furukawa
	藤林:フジバヤシ:fujibayashi
	一ノ瀬:イチノセ:ichinose
}

given_names = %w{
	朋也:トモヤ:tomoya
	陽平:ヨウヘイ:yohei
	渚:ナギサ:nagisa
	ことみ:コトミ:kotomi
	風子:フウコ:fuko
}

20.times do |n|
	fn = family_names[n % 4].split(':')
	gn = given_names[n % 5].split(':')

	User.create!(
		email: "#{fn[2]}.#{gn[2]}@example.com",
		family_name: fn[0],
		given_name: gn[0],
		family_name_kana: fn[1],
		given_name_kana: gn[1],
		password: 'password',
		start_date: (100 - n).days.ago.to_date,
		end_date: n == 0 ? Date.today : nil,
		suspended: n == 1
	)
end

