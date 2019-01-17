class HomeController < ApplicationController
	def search
		@main_news = MainNews.search('*').results
		@lots =  Lot.search('*').results
		
		if params[:query].present?
			@searching = Search.new.search(params[:query])
		else
			@searching = nil
		end
	end
end