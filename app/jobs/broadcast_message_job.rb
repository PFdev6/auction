class BroadcastMessageJob < ApplicationJob
  queue_as :default
  self.queue_adapter = :async

  def perform(message)
    ActionCable.server.broadcast "notification_#{message.user_id}", render_message(message)
    p "------#{message.user_id}"
    p message
    p "________________________________________________"
    p "msg use #{message.user_id}"
    p "________________________________________________"
  end
  
  def render_message(message)
    ApplicationController.renderer.render(message)
  end
end
