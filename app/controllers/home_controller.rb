class HomeController < ApplicationController
	def search
		if params[:query].present?
			page = params[:page] || 1
			@searching = Search.new.search(params[:query], page)
		else
			@searching = nil
		end
	end
end