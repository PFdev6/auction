module CurrentBargainsHelper
  def get_winner_info(id)
    user_winner = User.find_by(id: id)
    item = image_tag(user_winner.avatar.url(:thumb), width:'50', height:'50')
    link = link_to(t('Winner'), user_path(user_winner))
    content_tag(:div, class: 'alert alert-success') do
      concat content_tag(:div,item)
      concat content_tag(:div,link)
    end
  end
end