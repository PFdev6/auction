class BroadcastMessage
  include Interactor
  def call
    time_end = context.bargain.lot.lot_end_date + 15 #plus 15 second
    if context.autopurchase_price.present?
      BroadcastMessageJob.set(wait_until: Time.now + 10).perform_later(context.bargain)
    else 
      BroadcastMessageJob.set(wait_until: time_end).perform_later(context.bargain)
    end 
  end
end