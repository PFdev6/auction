class DeterminingTheWinnerJob < ApplicationJob
  queue_as :default
  
  
  def perform(current_bargain)
    p '-----------------------------------------------------'
    determine_winner(current_bargain)
    p self.job_id
    p '-----------------------------------------------------'
  end

  private 
  def determine_winner(current_bargain)
    current_bargain = CurrentBargain.find_by(id: current_bargain)
    CurrentBargain.transaction do
      if(current_bargain.id_user_winner.nil?)
        puts 'end time'
        Message.create(msg: 'No bet', user: current_bargain.user, current_bargain: current_bargain)
        return
      elsif(add_time?(current_bargain))      
        puts 'add time'
        puts current_bargain.lot.lot_end_date 'lot'
        current_bargain.lot.update_attributes(lot_end_date: current_bargain.lot.lot_end_date + 1800)
        puts current_bargain.lot.lot_end_date 'lot +1000'
        DeterminingTheWinnerJob.set(wait_until: current_bargain.lot.lot_end_date).perform_later(current_bargain)   
        Message.create(msg: '30 minutes was added',  user: current_bargain.user, current_bargain: current_bargain)
        current_bargain.users.each do |user|
          puts user.name
          Message.create(msg: '30 minutes was added', user: user, current_bargain: current_bargain)
        end
        return
      else
        puts 'played out'
        current_bargain.update_attributes(played_out: true)
        Message.create(msg: 'Played Out', user: current_bargain.user, current_bargain: current_bargain)
        winner = User.find_by(id: current_bargain.id_user_winner)
        Message.create(msg: 'You win', user: winner, current_bargain: current_bargain)

        current_bargain.users.each do |user|
          Message.create(msg: 'Your bid failed', user: user, current_bargain: current_bargain) if user != winner
        end
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
