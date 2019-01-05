class UpdateNotificationsChannel < ApplicationCable::Channel
  def subscribed
    id = params[:id]
    stream_from "update_bargain:#{id}" if id.present?
  end

  def unsubscribed
    stop_all_streams
  end 

  def test(msg)
    ActionCable.server.broadcast "update_bargain:#{params[:id]}", msg['message']    
  end
end
