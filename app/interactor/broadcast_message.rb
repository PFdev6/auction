class BroadcastMessage
  include Interactor
  def call
    time_end = context.bargain.lot.lot_end_date + 10 #plus 5 second
    BroadcastMessageJob.set(wait_until: time_end).perform_later(context.bargain)
  end
end