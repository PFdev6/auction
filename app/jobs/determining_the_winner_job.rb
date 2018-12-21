class DeterminingTheWinnerJob < ApplicationJob
  queue_as :default

  def perform(current_bargain)
    current_bargain.determine_winner
  end
end
