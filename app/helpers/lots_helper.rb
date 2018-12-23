module LotsHelper
  def get_all_tag(tags, classes)
    max = tags.sort_by(&:count).last
    tags.each do |tag|
      index = tag.count.to_f / max.count * (classes.size-1)
      yield(tag, classes[index.round])
    end
  end

  def get_imgdescr(lot)
    imgs = []
    imgs.push(lot.first_additional_image) if lot.first_additional_image.file?
    imgs.push(lot.second_additional_image) if lot.second_additional_image.file?
    imgs
  end

  def get_link_winner(current_bargain)
    return content_tag(:div,t('current_bargain.no_winner'), class: "badge badge-dark") if current_bargain.nil?
    user_winner = User.find_by(id: current_bargain.id_user_winner)
    if user_winner
      link_to(t('current_bargain.winner'), user_path(user_winner), class: "badge badge-dark")
    end
  end
end
