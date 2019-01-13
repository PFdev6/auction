class UpdateCurrentBargain
  include Interactor
  def call
    current_bargain = CurrentBargain.find(context.params[0][:current_bargain_id])
    new_price = context.params[0][:new_price]
    user = context.user
    context.current_bargain = current_bargain
    CurrentBargain.transaction do
      current_price = current_bargain.current_price
      if new_price >= current_bargain.lot.autopurchase_price
        current_bargain.users << user
        Delayed::Job.find_by(id: current_bargain.delayed_job_id).destroy
        id_job = DeterminingTheWinnerJob.perform_later(current_bargain).provider_job_id
        BroadcastMessage.call(bargain: current_bargain, autopurchase_price: true)
        current_bargain.update_attributes(
          current_price: new_price, 
          id_user_winner: user.id, 
          played_out: true, 
          delayed_job_id: id_job
        )        
      elsif new_price > current_price
        current_bargain.update_attributes(
          current_price: new_price, 
          id_user_winner: user.id
        )
        current_bargain.users << user
        current_bargain.id_user_winner = user
      else
        context.fail!(errors: "current_price: #{current_price.to_s}")
      end
    end
    context.current_bargain
  end
end