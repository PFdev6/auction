class Search
	def search(search_word)
		@searching = []
		@searching << result_news(search_word) << result_lot(search_word) <<  result_bargain(search_word)
	end

	private

	def result_lot(search_word)
		Lot.search(search_word)
	end

	def result_news(search_word)
		MainNews.search(search_word)
	end

	def result_bargain(search_word)
		CurrentBargain.includes(:lot).search(search_word)
	end
end