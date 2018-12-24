class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'notification_#{current_user.id}_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def notify(data)
    #Message.create(msg: data['message'], user_id: data['user']) 
    ActionCable.server.broadcast 'notification_#{current_user.id}_channel', data
  end
end
