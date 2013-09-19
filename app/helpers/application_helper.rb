module ApplicationHelper
	def full_title(page_title)
		base_title = "My Tots"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def pluralize_without_count(count, noun, text = nil)
	  	count == 1 ? " #{noun}#{text}" : "#{noun.pluralize}#{text}"
	end
end
