class MainNews < ApplicationRecord
  searchkick word_start: [:title, :description], word_middle:[:title, :description]
  def search_data
    {
      title: title,
      description: description
    }
  end

  belongs_to :user
  validates :title, :description, presence: true 
end
