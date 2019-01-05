class UpdateNotificationsChannel < ApplicationCable::Channel
  def subscribed
   # bargain_id = params[:id]
    #stream_from "bargain_#{bargain_id}"
    stream_from "update_bargain"
  end

  def test(msg)
    ActionCable.server.broadcast "update_bargain", "<p>#{msg['message']}</p>"    
  end
end
