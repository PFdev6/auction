module Resultable
  include ActiveSupport::Concern
	
	private

	def result_lot(search_word)
		Lot.search(search_word)
	end

	def result_news(search_word)
		MainNews.search(search_word)
	end

	def result_bargain(search_word)
		CurrentBargain.preload(:lot).search(search_word)
	end
end