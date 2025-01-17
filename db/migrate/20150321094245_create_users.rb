class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
			t.string :email, null: false
			t.string :email_for_index, null: false
			t.string :family_name, null: false
			t.string :given_name, null: false
			t.string :family_name_kana, null: false
			t.string :given_name_kana, null: false
			t.string :hashed_password
			t.date :start_date, null: false
			t.date :end_date
			t.boolean :suspended, null: false, default: false

			t.timestamps
    end

		add_index :users, :email_for_index, unique: true
		add_index :users, [ :family_name_kana, :given_name_kana ]
  end
end
