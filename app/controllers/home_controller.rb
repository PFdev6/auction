class HomeController < ApplicationController
	def search
		if params[:query].present?
			@searching = Search.new.search(params[:query])
		else
			@searching = nil
		end
	end
end