module HomeHelper
  
  def get_links_lots(lots)
    content_tag(:div, class: 'col-lg-12', width: '100%') do
      lots.each do |lot|
        concat content_tag(:div, link_to("Name: #{lot.name}, created at #{lot.created_at.strftime('%R %d/%m/%Y')}", lot_path(lot)), class:'btn col-lg-12 border border-danger', width: '100%')
      end
    end
  end

  def get_links_mainnews(all_news)
    content_tag(:div,  class: 'col-lg-12', width: '100%') do
      all_news.each do |news|
        concat content_tag(:div, link_to("Title: #{news.title}, created at: #{news.created_at.strftime('%R %d/%m/%Y')}", main_news_path(news)), class:'btn col-lg-12  border border-danger', width: '100%')
      end
    end
  end

  def get_links_burgains(bargains)
    content_tag(:div,  class: 'col-lg-12', width: '100%') do
      bargains.each do |bargain|
        concat content_tag(:div, link_to("Bargain: #{bargain.id}, created at: #{bargain.created_at.strftime('%R %d/%m/%Y')}", current_bargain_path(bargain)), class:'btn col-lg-12  border border-danger', width: '100%')
      end
    end
  end

end
