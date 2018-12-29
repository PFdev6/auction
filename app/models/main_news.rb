class MainNews < ApplicationRecord
  searchkick word_start: [:title, :user, :description], word_middle:[:title, :user, :description]
  scope :search_import, -> { includes(:user) }
  def search_data
    {
      title: title,
      user: user.nickname,
      description: description
    }
  end
  belongs_to :user
  validates :title, :description, presence: true 
end
