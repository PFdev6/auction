module ApplicationHelper
	def search_result_link(result)
		case result[:record_type]
		when 'MainNews'
			blog_post_path(result[:record_id])
		# when 'CurrentBargain'
		# 	article_path(result[:record_id])
		# when 'Lot'
		# 	news_path(result[:record_id])
		end
	end
end
