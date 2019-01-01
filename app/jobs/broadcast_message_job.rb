class BroadcastMessageJob < ApplicationJob
  queue_as :default
  self.queue_adapter = :async

  def perform
    msgs = choose_msgs
    p msgs
    msgs.each do |msg|
      ActionCable.server.broadcast "notification_#{msg.user_id}", ApplicationController.renderer.render(msg)
    end
  end
  
  def render_message(message)
    ApplicationController.renderer.render(message)
  end

  def choose_msgs
    msgs = Message.where( 
      "created_at >= :five_minutes_ago",
      five_minutes_ago: Time.now - 3.minutes
      )
  end
end
