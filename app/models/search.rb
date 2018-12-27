class Search
	def search(search_word)
		@searching = {main_news: result_news(search_word), lots: result_lot(search_word), current_bargains: result_bargain(search_word)}
	end

	private

	def result_lot(search_word)
		Lot.search(search_word).to_a
	end

	def result_news(search_word)
		MainNews.search(search_word).to_a
	end

	def result_bargain(search_word)
		CurrentBargain.search(search_word).to_a
	end
end