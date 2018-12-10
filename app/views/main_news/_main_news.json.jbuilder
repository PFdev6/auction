json.extract! main_news, :id, :title, :description, :created_at, :updated_at
json.url main_news_url(main_news, format: :json)
