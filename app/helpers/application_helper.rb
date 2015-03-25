module ApplicationHelper
	include HtmlBuilder

	def document_title
		if @title.present?
			"#{@title} - Teamdev"
		else
			'Teamdev'
		end
	end
end
