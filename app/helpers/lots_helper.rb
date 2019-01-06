module LotsHelper
  def get_all_tag(tags, classes)
    tags = tags.sort_by(&:count).reverse[0..4]
    max = tags.first
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

  def show_filter?
    return true if @lots.count > 2
    false
  end

  def stopped?(lot)
    return false if lot.inprocess
    true
  end

  def process?(lot)
    if lot.current_bargain 
      return false if lot.current_bargain.played_out
    end
    return true if lot.lot_end_date > Time.now

    true
  end

  def expired?(lot)
    return true if lot.current_bargain.id_user_winner.nil?
    return true if lot.lot_end_date < Time.now

    if lot.current_bargain
      return true if lot.current_bargain.played_out
    end
    false
  end

  def get_link_winner(current_bargain)
    return content_tag(:div, t('current_bargain.no_winner'), class: 'badge badge-dark') if current_bargain.id_user_winner.nil?
   
    user_winner = User.find_by(id: current_bargain.id_user_winner)
    if user_winner
      link_to(t('current_bargain.winner'), user_path(user_winner), class: 'badge badge-dark')
    end
  end

  def is_there_winner?(current_bargain)
    return true if current_bargain.id_user_winner.nil? && current_bargain.lot.lot_end_date < Time.now 
    false
  end
end
