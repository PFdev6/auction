module MessagesHelper
  def like_to(message)
    CurrentBargain.find_by(id: message.current_bargain_id).user
    # content_tag(:div, button_to("Like The Lot Organizer", { :action => "update", :id => current_.id },
    # :method => :delete), class:'badge border border-danger')
  end 
end