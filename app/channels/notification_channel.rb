class NotificationChannel < ApplicationCable::Channel
  def subscribed
    p "------------------------#{current_user.nickname}-------------------------"
    stream_from "notification_#{current_user.id}"
  end

  def notify(data)
    p "------------------------#{data}-------------------------"
    Message.create(msg: data['message'], user_id: data['user'])
    ActionCable.server.broadcast "notification_#{message.user_id}", render_message(Message.last)    
  end
end
