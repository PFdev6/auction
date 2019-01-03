class BroadcastMessageJob < ApplicationJob
  queue_as :default
  self.queue_adapter = :async

  def perform(bargain)
    msgs = choose_msgs(bargain)
    p bargain #creating many msg 
    msgs.each do |msg|
      ActionCable.server.broadcast "notification_#{msg.user_id}", render_message(msg)
    end
  end
  
  def render_message(message)
    ApplicationController.renderer.render(message)
  end

  def choose_msgs(bargain)
    Message.where(current_bargain: bargain) #add time 
  end
end
