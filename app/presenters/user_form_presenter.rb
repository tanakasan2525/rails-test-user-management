class UserFormPresenter < FormPresenter
	def password_field_block(name, label_text, options = {})
		if object.new_record?
			super(name, label_text, options)
		else
			markup(:div, class: 'input-block') do |m|
				m << decorated_label(name, label_text, options.merge(required: false))
				m << password_field(name, options.merge(disabled: true))
				m.button('Edit', type: 'button', id: 'enable-password-field')
				m.button('Don\'t edit', type: 'button', id: 'disable-password-field',
								 style: 'display: none')
				m << error_messages_for(name)
			end
		end
	end

	def full_name_block(name1, name2, label_text, options = {})
		markup(:div, class: 'input-block') do |m|
			m << decorated_label(name1, label_text, options)
			m << text_field(name1, options)
			m << text_field(name2, options)
			m << error_messages_for(name1)
			m << error_messages_for(name2)
		end
	end

	def check_boxes
		markup(:div, class: 'input-block') do |m|
			m << check_box(:suspended)
			m << label(:suspended, 'Freezed Account')
		end
	end
end
