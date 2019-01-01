class CurrentBargain < ApplicationRecord
  searchkick word_start: [:name, :user, :description], word_middle:[:name, :user, :description]
  scope :search_import, -> { includes(:users, :lot) }
  def search_data
    {
      name: lot.name,
      user: user.nickname,
      description: lot.description
    }
  end
  has_many :messages, :dependent => :destroy
  belongs_to :user
  has_many :users
  has_one :delayed_job, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :lot
end
