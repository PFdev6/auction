class DeterminingTheWinnerJob < ApplicationJob
  queue_as :default

  def perform(current_bargain)
    DetermineWinner.call(params: current_bargain)
  end
end
