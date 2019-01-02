class BroadcastMessage
  include Interactor
  def call
    time_end = context.params[0][:time]
    BroadcastMessageJob.set(wait_until: time_end+10).perform_later
  end
end