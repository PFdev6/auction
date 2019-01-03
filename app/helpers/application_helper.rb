module ApplicationHelper
	def search_result_link(result)
		case result[:record_type]
		when 'MainNews'
			blog_post_path(result[:record_id])
		end
	end

end
