class Search
	include Resultable

	def search(search_word)
		@searching = []
		@searching << result_news(search_word) << result_lot(search_word) <<  result_bargain(search_word)
	end

end