module MessagesHelper
  def like_to(message)
    message.current_bargain.user
  end 
end