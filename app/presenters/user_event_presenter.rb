class UserEventPresenter < ModelPresenter
	delegate :user, :description, :occurred_at, to: :object

	def table_row
		markup(:tr) do |m|
			unless view_context.instance_variable_get(:@user)
				m.td do
					m << link_to(user.family_name + user.given_name,
						[ :admin, user, :user_events ])
				end
			end
			m.td description
			m.td(:class => 'date') do
				m.text occurred_at.strftime('%Y/%m/%d %H:%M:%S')
			end
		end
	end
end
