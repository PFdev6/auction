class DeterminingTheWinnerJob < ApplicationJob
  queue_as :default
  def perform(current_bargain)
    puts '-----------------------------------------------------'
    determine_winner(current_bargain)
    puts '-----------------------------------------------------'
  end

  private 
  def determine_winner(current_bargain)
    current_bargain = CurrentBargain.find_by(id: current_bargain)
    return nil if current_bargain.id_user_winner.nil? 
    CurrentBargain.transaction do
      if(add_time?(current_bargain))
        puts current_bargain.lot.lot_end_date 'lot'
        current_bargain.lot.update_attributes(lot_end_date: current_bargain.lot.lot_end_date + 1000)
        puts current_bargain.lot.lot_end_date 'lot +1000'
        DeterminingTheWinnerJob.set(wait_until: current_bargain.lot.lot_end_date).perform_later(current_bargain)   
      else
        current_bargain.update_attributes(played_out: false)
        #msg!!!!
      end
    end
  end 

  def add_time?(current_bargain)
    five_second_to = current_bargain.lot.lot_end_date - 5
    puts five_second_to
    puts 'fivesecond'
    if(current_bargain.lot.lot_end_date < current_bargain.updated_at && current_bargain.updated_at <  five_second_to + 5)
      return true
    end
    return false
  end 
end
