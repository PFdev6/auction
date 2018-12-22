class DetermineWinner
  include Interactor

  def call
    current_bargain = CurrentBargain.find(context.params[:current_bargain])
    return nil if current_bargain.id_user_winner.nil? 
    CurrentBargain.transaction do
      if(add_time?(current_bargain))
        current_bargain.lot.update_attributes(lot_end_date: current_bargain.lot.lot_end_date + 1000)
        DeterminingTheWinnerJob.set(wait_until: current_bargain.lot.lot_end_date).perform_later(current_bargain)   
      else
        current_bargain.lot.update_attributes(played_out: false)
        context.current_bargain = current_bargain
        #msg!!!!
      end
    end
  end

  def add_time?(current_bargain)
    five_second_to = current_bargain.lot.lot_end_date - 5
    if(current_bargain.lot.lot_end_date < current_bargain.update_at <  five_second_to + 5)
      return true
    end
    return false
  end 
end
