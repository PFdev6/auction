json.main_news do
  json.array!(@main_news) do |news|
    json.title news.title
    json.url main_news_path(news)
  end
end

json.lots do
  json.array!(@lots) do |lot|
    json.name lot.name
    json.url lot_path(lot)
  end
end