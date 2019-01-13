class HomeController < ApplicationController
	def search
		request.format = :json
		@main_news = MainNews.ransack(params[:query]).result(distinct: true)
		@lots =  Lot.ransack(params[:query]).result(distinct: true)

		if params[:query].present?
			@searching = Search.new.search(params[:query])
		else
			@searching = nil
		end
	end
end