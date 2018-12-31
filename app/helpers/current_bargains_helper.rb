module CurrentBargainsHelper
  def get_winner_info(id)
    user_winner = User.find_by(id: id)
    item = image_tag(user_winner.avatar.url(:thumb), width:'50', height:'50', class: 'rounded-circle')
    link = link_to(user_winner.nickname, user_path(user_winner), class:'btn')
    content_tag(:div, class: 'alert border border-success') do
      concat content_tag(:h1,'Winner: ', class: 'col-4')
      concat content_tag(:div,item, class: 'col-4')
      concat content_tag(:div,link)
    end
  end

  def stopped?(lot)
    return false if lot.inprocess
    true
  end
end