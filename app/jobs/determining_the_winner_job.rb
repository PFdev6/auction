class DeterminingTheWinnerJob < ApplicationJob
  queue_as :default

  def perform(current_bargain)
    @current_bargain = current_bargain
    p '-----------------------------------------------------'
    determine_winner(current_bargain)
    p self.job_id
    p '-----------------------------------------------------'
  end

  private 
  def determine_winner(current_bargain)
    current_bargain = CurrentBargain.find_by(id: current_bargain)
    CurrentBargain.transaction do   
      if current_bargain.id_user_winner.nil?
        puts 'end time'
        new_message('No bet', current_bargain.user, current_bargain)
        current_bargain.update_attributes(played_out: true)
      elsif add_time?(current_bargain)      
        puts 'add time'
        puts current_bargain.lot.lot_end_date 'lot'
        current_bargain.lot.update_attributes(lot_end_date: current_bargain.lot.lot_end_date + 1800)
        puts current_bargain.lot.lot_end_date 'lot +1000'
        #BroadcastMessage.call(bargain: current_bargain) add in callback after_update
        DeterminingTheWinnerJob.set(wait_until: current_bargain.lot.lot_end_date).perform_later(current_bargain)   
        new_message('30 minutes was added', current_bargain.user, current_bargain)
        current_bargain.users.each do |user|
          puts user.name
          new_message('30 minutes was added', user, current_bargain)
        end
      else
        puts 'played out'
        current_bargain.update_attributes(played_out: true)
        new_message('Played Out', current_bargain.user, current_bargain)
        winner = User.find_by(id: current_bargain.id_user_winner)
        new_message('You win', winner, current_bargain)
        current_bargain.users.each do |user|
          new_message('Your bid failed', user, current_bargain) if user != winner
        end
      end
    end
  end

  def new_message(msg_text, user, bargain)
    Message.create(msg: msg_text, user: user, current_bargain: bargain)
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
