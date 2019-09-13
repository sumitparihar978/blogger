module ApplicationHelper
	def shorten_link_new text
		auto_link(text) do |url|
			url.truncate 1200
		end
	end
end