class CreateUserEvents < ActiveRecord::Migration
  def change
    create_table :user_events do |t|
			t.references :user, null: false # ユーザーへの外部キー
			t.string :type, null: false
			t.datetime :created_at, null: false
		end

		add_index :user_events, :created_at
		add_index :user_events, [ :user_id, :created_at ]
		add_foreign_key :user_events, :users
  end
end
